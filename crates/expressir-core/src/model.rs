//! Declaration-level EXPRESS model (Phase 1 of TODO.max-perf/9).
//!
//! Mirrors the subset of `Expressir::Model` that the structural dump
//! parity gate covers: schema heads, entity heads with explicit
//! attribute names and WHERE labels, and the other declaration heads.
//! Statements, expressions, and remark attachment land in Phase 2.

use serde::{Deserialize, Serialize};

/// Root of a parsed EXPRESS file. Corresponds to
/// `Expressir::Model::Repository`.
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Repository {
    pub schemas: Vec<Schema>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Schema {
    pub name: String,
    pub version: Option<String>,
    pub entities: Vec<Entity>,
    pub types: Vec<TypeDecl>,
    pub functions: Vec<FunctionDecl>,
    pub procedures: Vec<ProcedureDecl>,
    pub rules: Vec<RuleDecl>,
    pub subtype_constraints: Vec<SubtypeConstraintDecl>,
    pub constants: Vec<ConstantDecl>,
}

/// Entity head + attribute names. Mirroring the Expressir builder,
/// `attributes` concatenates explicit, derived, and inverse attributes
/// in declaration order.
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Entity {
    pub name: String,
    pub attributes: Vec<Attribute>,
    pub where_rules: Vec<WhereRule>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Attribute {
    pub name: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct WhereRule {
    pub label: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TypeDecl {
    pub name: String,
    pub where_rules: Vec<WhereRule>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FunctionDecl {
    pub name: String,
    pub parameters: Vec<String>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ProcedureDecl {
    pub name: String,
    pub parameters: Vec<String>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct RuleDecl {
    pub name: String,
    pub where_rules: Vec<WhereRule>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SubtypeConstraintDecl {
    pub name: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ConstantDecl {
    pub name: String,
}
