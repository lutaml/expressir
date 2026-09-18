//! Dump a parsed EXPRESS file's arena AST as JSON, so extraction paths
//! can be verified against the real grammar output.
//!
//! Usage: `cargo run --example dump -- <file.exp> [out.json]`

use std::io::Write as _;

use expressir_core::ParsedTree;
use parsanol::portable::{AstArena, AstNode};
use serde_json::{json, Map, Value};

fn to_value(arena: &AstArena, node: &AstNode) -> Value {
    match node {
        AstNode::Nil => Value::Null,
        AstNode::Bool(b) => json!(b),
        AstNode::Int(i) => json!(i),
        AstNode::Float(f) => json!(f),
        AstNode::StringRef { pool_index } => {
            json!({ "s": arena.get_string(*pool_index as usize) })
        }
        AstNode::InputRef { offset, length } => {
            let input = arena.get_input();
            let s = input
                .get(*offset as usize..(*offset + *length) as usize)
                .unwrap_or("");
            json!({ "s": s, "at": offset })
        }
        AstNode::Array { pool_index, length } => Value::Array(
            arena
                .get_array(*pool_index as usize, *length as usize)
                .iter()
                .map(|n| to_value(arena, n))
                .collect(),
        ),
        AstNode::Hash { pool_index, length } => {
            let mut map = Map::new();
            for (k, v) in arena.get_hash_items(*pool_index as usize, *length as usize) {
                map.insert(k, to_value(arena, &v));
            }
            Value::Object(map)
        }
        _ => Value::Null,
    }
}

fn main() {
    let mut args = std::env::args().skip(1);
    let path = args.next().expect("usage: dump <file.exp> [out.json]");
    let out_path = args
        .next()
        .unwrap_or_else(|| format!("{}.ast.json", path));

    let source = std::fs::read_to_string(&path).expect("read input");
    let tree = ParsedTree::parse(&source).expect("parse");
    let value = to_value(tree.arena(), tree.root());
    let rendered = serde_json::to_string_pretty(&value).expect("render");

    let mut out = std::fs::File::create(&out_path).expect("create output");
    out.write_all(rendered.as_bytes()).expect("write output");
    eprintln!("wrote {}", out_path);
}
