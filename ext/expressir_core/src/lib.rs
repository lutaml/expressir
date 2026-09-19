//! Ruby bridge for expressir-core: exposes the Rust parse + model
//! extraction pipeline to the expressir gem.

use std::fs;

use expressir_rs::ParsedTree;
use magnus::{function, prelude::*, Error, Ruby};

fn model_json(ruby: &Ruby, path: String) -> Result<String, Error> {
    let source = fs::read_to_string(&path).map_err(|e| {
        Error::new(
            ruby.exception_io_error(),
            format!("expressir-core: cannot read {path}: {e}"),
        )
    })?;
    let tree = ParsedTree::parse(&source).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: parse error: {e:?}"),
        )
    })?;
    serde_json::to_string(&tree.to_model()).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: serialize error: {e}"),
        )
    })
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("Expressir")?.define_module("Core")?;
    module.define_singleton_method("model_json", function!(model_json, 1))?;
    Ok(())
}
