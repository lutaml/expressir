//! Dump the extracted declaration-level model as JSON.
//!
//! Usage: `cargo run --example model_dump -- <file.exp> [out.json]`

use std::io::Write as _;

fn main() {
    let mut args = std::env::args().skip(1);
    let path = args.next().expect("usage: model_dump <file.exp> [out.json]");
    let out_path = args
        .next()
        .unwrap_or_else(|| format!("{}.model.json", path));

    let source = std::fs::read_to_string(&path).expect("read input");
    let tree = expressir_core::ParsedTree::parse(&source).expect("parse");
    let rendered =
        serde_json::to_string_pretty(&tree.to_model()).expect("serialize model");

    let mut out = std::fs::File::create(&out_path).expect("create output");
    out.write_all(rendered.as_bytes()).expect("write output");
    eprintln!("wrote {}", out_path);
}
