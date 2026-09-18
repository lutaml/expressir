//! Navigation helpers over the parsanol arena AST.
//!
//! The Ruby-tier grammar serializes named rules as single-key hashes
//! (camelCase rule name → child value) and repetitions as arrays. These
//! helpers mirror the shapes the EXPRESS grammar produces without
//! forcing the extractor to pattern-match on `AstNode` variants.

use parsanol::portable::{AstArena, AstNode};

/// Value stored under `key` in a hash node.
pub fn hash_get(arena: &AstArena, node: &AstNode, key: &str) -> Option<AstNode> {
    match node {
        AstNode::Hash { pool_index, length } => arena
            .get_hash_items(*pool_index as usize, *length as usize)
            .into_iter()
            .find(|(k, _)| k == key)
            .map(|(_, v)| v),
        _ => None,
    }
}

/// Keys present in a hash node.
pub fn hash_keys(arena: &AstArena, node: &AstNode) -> Vec<String> {
    match node {
        AstNode::Hash { pool_index, length } => arena
            .get_hash_items(*pool_index as usize, *length as usize)
            .into_iter()
            .map(|(k, _)| k)
            .collect(),
        _ => Vec::new(),
    }
}

/// Elements of an array node (empty for anything else).
pub fn array_items(arena: &AstArena, node: &AstNode) -> Vec<AstNode> {
    match node {
        AstNode::Array { pool_index, length } => {
            arena.get_array(*pool_index as usize, *length as usize)
        }
        _ => Vec::new(),
    }
}

/// Treat a node as a list. Arrays yield their elements; a present
/// non-array node yields itself (the grammar's maybe/one-or-more
/// wrapping collapses single occurrences); nil yields nothing.
pub fn as_list(arena: &AstArena, node: &AstNode) -> Vec<AstNode> {
    match node {
        AstNode::Array { .. } => array_items(arena, node),
        AstNode::Nil => Vec::new(),
        other => vec![other.clone()],
    }
}

/// Resolve a node to its source text: input refs slice the original
/// input, string refs read the interned pool.
pub fn text(arena: &AstArena, node: &AstNode) -> Option<String> {
    match node {
        AstNode::StringRef { pool_index } => {
            Some(arena.get_string(*pool_index as usize).to_string())
        }
        AstNode::InputRef { offset, length } => {
            let input = arena.get_input();
            input
                .get(*offset as usize..(*offset + *length) as usize)
                .map(|s| s.to_string())
        }
        _ => None,
    }
}

/// Recursively yield every hash node reachable from `node`, including
/// `node` itself when it is a hash.
pub fn self_and_descendant_hashes<'a>(
    arena: &'a AstArena,
    node: &AstNode,
    out: &mut Vec<(String, AstNode)>,
) {
    match node {
        AstNode::Hash { pool_index, length } => {
            for (key, value) in arena.get_hash_items(*pool_index as usize, *length as usize) {
                out.push((key, value.clone()));
                self_and_descendant_hashes(arena, &value, out);
            }
        }
        AstNode::Array { .. } => {
            for item in array_items(arena, node) {
                self_and_descendant_hashes(arena, &item, out);
            }
        }
        _ => {}
    }
}
