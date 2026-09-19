//! Stage-level benchmark: parse vs parslet-normalize vs extract vs
//! serialize on a giant EXPRESS file.
//!
//! Usage: `cargo run --release --example stage_bench -- <file.exp>`

use std::time::Instant;

use expressir_core::ParsedTree;
use parsanol::portable::{AstArena, Grammar, PortableParser};

const EXPRESS_GRAMMAR_JSON: &str = include_str!("../assets/express-grammar.json");

fn main() {
    let path = std::env::args().nth(1).expect("usage: stage_bench <file.exp>");
    let source = std::fs::read_to_string(&path).expect("read input");
    println!("{} ({} KB)", path, source.len() / 1024);

    let runs: usize = std::env::args()
        .nth(2)
        .and_then(|s| s.parse().ok())
        .unwrap_or(3);

    let grammar = Grammar::from_json(EXPRESS_GRAMMAR_JSON).expect("grammar");

    let mut parse_t = f64::MAX;
    let mut full_t = f64::MAX;
    let mut json_bytes = 0usize;

    for _ in 0..runs {
        let t0 = Instant::now();
        let mut arena = AstArena::for_input(source.len());
        arena.set_input(source.clone());
        let mut parser = PortableParser::new(&grammar, &source, &mut arena);
        let _raw = parser.parse().expect("parse");
        parse_t = parse_t.min(t0.elapsed().as_secs_f64());
    }

    for _ in 0..runs {
        let t0 = Instant::now();
        let tree = ParsedTree::parse(&source).expect("parse");
        let model = tree.to_model();
        let t1 = t0.elapsed().as_secs_f64();
        let json = serde_json::to_string(&model).expect("json");
        json_bytes = json.len();
        full_t = full_t.min(t1);
    }

    println!("  parse (walker)          : {:6.2} s", parse_t);
    println!("  parse+norm+extract      : {:6.2} s", full_t);
    println!("  model JSON              : {} KB", json_bytes / 1024);
}
