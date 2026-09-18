//! AST → model extraction (Phase 1): walks the parslet-shaped arena
//! tree and produces the declaration-level `Repository`.
//!
//! The grammar wraps every named rule in a single-key camelCase hash,
//! so extraction is mostly `hash_get` chains mirroring the Ruby-tier
//! rule names. Paths verified against dumps of the `spec/syntax`
//! fixtures (`examples/dump.rs`).

use parsanol::portable::{AstArena, AstNode};

use crate::model::*;
use crate::walk::{as_list, hash_get, text};
use crate::ParsedTree;

/// Extract the declaration-level model from a parsed tree.
pub fn extract_file(tree: &ParsedTree) -> Repository {
    let arena = tree.arena();
    let root = tree.root();
    let mut schemas = Vec::new();

    if let Some(syntax) = hash_get(arena, root, "syntax") {
        if let Some(schema_decls) = hash_get(arena, &syntax, "schemaDecl") {
            for wrapped in as_list(arena, &schema_decls) {
                if let Some(inner) = hash_get(arena, &wrapped, "schemaDecl") {
                    schemas.push(extract_schema(arena, &inner));
                }
            }
        }
    }

    Repository { schemas }
}

fn extract_schema(arena: &AstArena, decl: &AstNode) -> Schema {
    let name = rule_id_str(arena, hash_get(arena, decl, "schemaId").as_ref());
    let version = hash_get(arena, decl, "schemaVersionId")
        .as_ref()
        .and_then(|v| hash_get(arena, v, "stringLiteral"))
        .and_then(|l| hash_get(arena, &l, "simpleStringLiteral"))
        .and_then(|s| hash_get(arena, &s, "str"))
        .and_then(|n| text(arena, &n))
        .map(unquote);

    let mut schema = Schema {
        name,
        version,
        entities: Vec::new(),
        types: Vec::new(),
        functions: Vec::new(),
        procedures: Vec::new(),
        rules: Vec::new(),
        subtype_constraints: Vec::new(),
        constants: Vec::new(),
    };

    if let Some(body) = hash_get(arena, decl, "schemaBody").as_ref() {
        extract_body(arena, body, &mut schema);
    }
    schema
}

fn extract_body(arena: &AstArena, body: &AstNode, schema: &mut Schema) {
    if let Some(constant_decl) = hash_get(arena, body, "constantDecl") {
        extract_constant_decl(arena, &constant_decl, schema);
    }

    let Some(declarations) = hash_get(arena, body, "schemaBodyDeclaration") else {
        return;
    };
    for wrapped in as_list(arena, &declarations) {
        let Some(outer) = hash_get(arena, &wrapped, "schemaBodyDeclaration") else {
            continue;
        };
        // Most declarations nest one level deeper under "declaration";
        // ruleDecl sits directly under the wrapper (the EXPRESS grammar
        // keeps rule_decl outside the declaration alternatives).
        let declaration = hash_get(arena, &outer, "declaration").unwrap_or(outer);
        dispatch_declaration(arena, &declaration, schema);
    }
}

fn dispatch_declaration(arena: &AstArena, declaration: &AstNode, schema: &mut Schema) {
    if let Some(node) = hash_get(arena, declaration, "entityDecl") {
        schema.entities.push(extract_entity(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "typeDecl") {
        schema.types.push(extract_type(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "functionDecl") {
        schema.functions.push(extract_function(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "procedureDecl") {
        schema.procedures.push(extract_procedure(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "ruleDecl") {
        schema.rules.push(extract_rule(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "subtypeConstraintDecl") {
        schema.subtype_constraints.push(extract_subtype_constraint(arena, &node));
    } else if let Some(node) = hash_get(arena, declaration, "constantDecl") {
        extract_constant_decl(arena, &node, schema);
    }
}

fn extract_entity(arena: &AstArena, node: &AstNode) -> Entity {
    let mut entity = Entity {
        name: String::new(),
        attributes: Vec::new(),
        where_rules: Vec::new(),
    };

    if let Some(head) = hash_get(arena, node, "entityHead") {
        entity.name = rule_id_str(arena, hash_get(arena, &head, "entityId").as_ref());
    }
    if let Some(body) = hash_get(arena, node, "entityBody") {
        // The Expressir builder concatenates explicit, derived, and
        // inverse attributes into a single `attributes` collection in
        // declaration order (derived_attributes stays empty).
        if let Some(explicit_attr) = hash_get(arena, &body, "explicitAttr") {
            for attr in as_list(arena, &explicit_attr) {
                collect_attributes(arena, &attr, &mut entity.attributes);
            }
        }
        if let Some(derive_clause) = hash_get(arena, &body, "deriveClause") {
            if let Some(derived_attr) = hash_get(arena, &derive_clause, "derivedAttr") {
                for attr in as_list(arena, &derived_attr) {
                    collect_attributes(arena, &attr, &mut entity.attributes);
                }
            }
        }
        if let Some(inverse_clause) = hash_get(arena, &body, "inverseClause") {
            if let Some(inverse_attr) = hash_get(arena, &inverse_clause, "inverseAttr") {
                for attr in as_list(arena, &inverse_attr) {
                    collect_attributes(arena, &attr, &mut entity.attributes);
                }
            }
        }
        entity.where_rules = collect_where_rules(arena, &body);
    }
    entity
}

/// Attribute lists arrive in several shapes (`a, b : T` groups, single
/// declarations, redeclared attributes). Recurse through the subtree
/// and take the identifier from every `attributeDecl` wrapper — plain
/// `attributeId` or a redeclared reference `SELF\ent.attr`.
fn collect_attributes(arena: &AstArena, node: &AstNode, out: &mut Vec<Attribute>) {
    if let Some(attr_decl) = hash_get(arena, node, "attributeDecl") {
        if let Some(name) =
            rule_id_str_opt(arena, hash_get(arena, &attr_decl, "attributeId").as_ref())
        {
            out.push(Attribute { name });
            return;
        }
        if let Some(re) = hash_get(arena, &attr_decl, "redeclaredAttribute") {
            if let Some(name) = redeclared_attribute_name(arena, &re) {
                out.push(Attribute { name });
            }
        }
        return;
    }
    if let Some(re) = hash_get(arena, node, "redeclaredAttribute") {
        if let Some(name) = redeclared_attribute_name(arena, &re) {
            out.push(Attribute { name });
        }
        return;
    }
    match node {
        AstNode::Hash { pool_index, length } => {
            for (_, value) in arena.get_hash_items(*pool_index as usize, *length as usize) {
                collect_attributes(arena, &value, out);
            }
        }
        AstNode::Array { .. } => {
            for item in as_list(arena, node) {
                collect_attributes(arena, &item, out);
            }
        }
        _ => {}
    }
}

/// Redeclared attribute name: either a direct `attributeId` or a
/// qualified reference `SELF\entity.attr`
/// (qualifiedAttribute.attributeQualifier.attributeRef.attributeId).
fn redeclared_attribute_name(arena: &AstArena, redeclared: &AstNode) -> Option<String> {
    if let Some(name) = rule_id_str_opt(arena, hash_get(arena, redeclared, "attributeId").as_ref())
    {
        return Some(name);
    }
    let qualified = hash_get(arena, redeclared, "qualifiedAttribute")?;
    let attr_ref = hash_get(arena, &qualified, "attributeRef")
        .or_else(|| {
            hash_get(arena, &qualified, "attributeQualifier")
                .and_then(|q| hash_get(arena, &q, "attributeRef"))
        })?;
    rule_id_str_opt(arena, hash_get(arena, &attr_ref, "attributeId").as_ref())
}

/// WHERE labels from `whereClause.listOf_domainRule[i].domainRule`.
/// Unlabeled rules (no `ruleLabelId`) are skipped; they carry no name
/// at the declaration level.
fn collect_where_rules(arena: &AstArena, node: &AstNode) -> Vec<WhereRule> {
    let mut rules = Vec::new();
    let where_clause = hash_get(arena, node, "whereClause");
    let Some(where_clause) = where_clause.as_ref() else {
        return rules;
    };
    if let Some(list) = hash_get(arena, where_clause, "listOf_domainRule") {
        for item in as_list(arena, &list) {
            if let Some(domain_rule) = hash_get(arena, &item, "domainRule") {
                if let Some(label) = rule_id_str_opt(
                    arena,
                    hash_get(arena, &domain_rule, "ruleLabelId").as_ref(),
                ) {
                    rules.push(WhereRule { label });
                }
            }
        }
    }
    rules
}

fn extract_type(arena: &AstArena, node: &AstNode) -> TypeDecl {
    let name = rule_id_str(arena, hash_get(arena, node, "typeId").as_ref());
    TypeDecl {
        name,
        where_rules: collect_where_rules(arena, node),
    }
}

fn extract_function(arena: &AstArena, node: &AstNode) -> FunctionDecl {
    let head = hash_get(arena, node, "functionHead");
    let name = rule_id_str(
        arena,
        head.as_ref()
            .and_then(|h| hash_get(arena, &h, "functionId"))
            .as_ref(),
    );
    let parameters = head
        .as_ref()
        .and_then(|h| hash_get(arena, h, "listOf_formalParameter"))
        .map(|params| collect_parameter_ids(arena, &params))
        .unwrap_or_default();
    FunctionDecl { name, parameters }
}

fn extract_procedure(arena: &AstArena, node: &AstNode) -> ProcedureDecl {
    let head = hash_get(arena, node, "procedureHead");
    let name = rule_id_str(
        arena,
        head.as_ref()
            .and_then(|h| hash_get(arena, &h, "procedureId"))
            .as_ref(),
    );
    let parameters = head
        .as_ref()
        .and_then(|h| hash_get(arena, h, "listOf_procedureHeadParameter"))
        .map(|params| collect_parameter_ids(arena, &params))
        .unwrap_or_default();
    ProcedureDecl { name, parameters }
}

fn extract_rule(arena: &AstArena, node: &AstNode) -> RuleDecl {
    let head = hash_get(arena, node, "ruleHead");
    let name = rule_id_str(
        arena,
        head.as_ref()
            .and_then(|h| hash_get(arena, &h, "ruleId"))
            .as_ref(),
    );
    RuleDecl {
        name,
        where_rules: collect_where_rules(arena, node),
    }
}

fn extract_subtype_constraint(arena: &AstArena, node: &AstNode) -> SubtypeConstraintDecl {
    let head = hash_get(arena, node, "subtypeConstraintHead");
    let name = rule_id_str(
        arena,
        head.as_ref()
            .and_then(|h| hash_get(arena, &h, "subtypeConstraintId"))
            .as_ref(),
    );
    SubtypeConstraintDecl { name }
}

fn extract_constant_decl(arena: &AstArena, node: &AstNode, schema: &mut Schema) {
    if let Some(constant_body) = hash_get(arena, node, "constantBody") {
        for item in as_list(arena, &constant_body) {
            if let Some(inner) = hash_get(arena, &item, "constantBody") {
                if let Some(name) =
                    rule_id_str_opt(arena, hash_get(arena, &inner, "constantId").as_ref())
                {
                    schema.constants.push(ConstantDecl { name });
                }
            }
        }
    }
}

/// Parameter names from `listOf_formalParameter` /
/// `listOf_procedureHeadParameter`. Items are optionally wrapped in
/// `procedureHeadParameter` and `formalParameter`; a group `a, b : T`
/// contributes both names via `listOf_parameterId`.
fn collect_parameter_ids(arena: &AstArena, node: &AstNode) -> Vec<String> {
    let mut ids = Vec::new();
    for param in as_list(arena, node) {
        let group = hash_get(arena, &param, "procedureHeadParameter").unwrap_or(param);
        let group = hash_get(arena, &group, "formalParameter").unwrap_or(group);
        if let Some(list) = hash_get(arena, &group, "listOf_parameterId") {
            if let Some(id) = hash_get(arena, &list, "parameterId") {
                if let Some(name) = rule_id_str_opt(arena, Some(&id)) {
                    ids.push(name);
                }
            } else {
                for item in as_list(arena, &list) {
                    if let Some(id) = hash_get(arena, &item, "parameterId") {
                        if let Some(name) = rule_id_str_opt(arena, Some(&id)) {
                            ids.push(name);
                        }
                    }
                }
            }
        }
    }
    ids
}

/// `xId` → `simpleId` → `str` → text; empty string when absent.
fn rule_id_str(arena: &AstArena, id_node: Option<&AstNode>) -> String {
    rule_id_str_opt(arena, id_node).unwrap_or_default()
}

/// Strip one layer of surrounding single quotes (string literals keep
/// their quotes in the tree; the model stores the bare value).
fn unquote(s: String) -> String {
    if s.len() >= 2 && s.starts_with('\'') && s.ends_with('\'') {
        s[1..s.len() - 1].to_string()
    } else {
        s
    }
}

fn rule_id_str_opt(arena: &AstArena, id_node: Option<&AstNode>) -> Option<String> {
    let id_node = id_node?;
    let simple = hash_get(arena, id_node, "simpleId").or_else(|| Some(id_node.clone()))?;
    let str_node = hash_get(arena, &simple, "str").or(Some(simple))?;
    text(arena, &str_node)
}
