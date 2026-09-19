//! Ruby bridge for expressir-core: exposes the Rust parse + model
//! extraction pipeline to the expressir gem.

use std::fs;

use expressir_rs::ParsedTree;
use magnus::{function, prelude::*, Error, Ruby};

fn model_json(ruby: &Ruby, source: String, path: String) -> Result<String, Error> {
    let tree = ParsedTree::parse(&source).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: parse error: {e:?}"),
        )
    })?;
    tree.to_model_json(&path)
        .map_err(|e| {
            Error::new(
                ruby.exception_runtime_error(),
                format!("expressir-core: model json error: {e:?}"),
            )
        })
        .and_then(|v| serde_json::to_string(&v).map_err(|e| {
            Error::new(
                ruby.exception_runtime_error(),
                format!("expressir-core: serialize error: {e}"),
            )
        }))
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("Expressir")?.define_module("Core")?;
    module.define_singleton_method("parse_to_model_hash", function!(model_json, 2))?;
    Ok(())
}
