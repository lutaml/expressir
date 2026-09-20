//! Ruby bridge for expressir-core: exposes the Rust parse + model
//! extraction pipeline to the expressir gem.
//!
//! Two entry points:
//! - `parse_to_model_hash` — the wire JSON string (tooling, parity runs)
//! - `parse_to_model` — the hydrated model, built by walking the wire
//!   JSON definition once and constructing each node through
//!   `Serializable.instantiate` (lutaml-model's fast bulk constructor).
//!   Skips the JSON string, `JSON.parse`, and the generic from_hash
//!   mapping machinery.

use std::collections::HashMap;

use expressir_rs::ParsedTree;
use magnus::function;
use magnus::prelude::*;
use magnus::IntoValue;
use magnus::{Error, RClass, RHash, RModule, Ruby};
use serde_json::Value as Wire;

fn parse_error(ruby: &Ruby, e: expressir_rs::model_json::ModelJsonError) -> Error {
    Error::new(
        ruby.exception_runtime_error(),
        format!("expressir-core: parse error: {e:?}"),
    )
}

fn model_json(ruby: &Ruby, source: String, path: String) -> Result<String, Error> {
    let tree = ParsedTree::parse(&source).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: parse error: {e:?}"),
        )
    })?;
    let value = tree.to_model_json(&path).map_err(|e| parse_error(ruby, e))?;
    serde_json::to_string(&value).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: serialize error: {e}"),
        )
    })
}

/// Resolves `Expressir::Model::*` classes by their wire `_class` name,
/// caching each lookup (the class set is closed).
#[derive(Default)]
struct ClassCache {
    classes: HashMap<String, RClass>,
}

impl ClassCache {
    fn resolve(&mut self, ruby: &Ruby, name: &str) -> Result<RClass, Error> {
        if let Some(klass) = self.classes.get(name) {
            return Ok(*klass);
        }

        let short = name.strip_prefix("Expressir::Model::").ok_or_else(|| {
            Error::new(
                ruby.exception_runtime_error(),
                format!("expressir-core: unknown model class {name:?}"),
            )
        })?;
        let mut current = ruby
            .class_object()
            .const_get::<_, RModule>("Expressir")?
            .const_get::<_, RModule>("Model")?;
        let segments: Vec<&str> = short.split("::").collect();
        let last = segments.len() - 1;
        for (i, segment) in segments.iter().enumerate() {
            let value = current
                .const_get::<_, magnus::Value>(segment.to_string())
                .map_err(|e| {
                    Error::new(
                        ruby.exception_runtime_error(),
                        format!("expressir-core: unknown model class {name:?}: {e}"),
                    )
                })?;
            if i == last {
                let klass = RClass::from_value(value).ok_or_else(|| {
                    Error::new(
                        ruby.exception_runtime_error(),
                        format!("expressir-core: {name:?} is not a class"),
                    )
                })?;
                self.classes.insert(name.to_string(), klass);
                return Ok(klass);
            }
            current = RModule::from_value(value).ok_or_else(|| {
                Error::new(
                    ruby.exception_runtime_error(),
                    format!("expressir-core: {name:?} is not a module"),
                )
            })?;
        }
        unreachable!()
    }
}

fn value_to_ruby(ruby: &Ruby, cache: &mut ClassCache, wire: &Wire) -> Result<magnus::Value, Error> {
    match wire {
        Wire::Null => Ok(ruby.qnil().as_value()),
        Wire::Bool(b) => Ok(b.into_value()),
        Wire::Number(n) => {
            if let Some(i) = n.as_i64() {
                Ok(ruby.integer_from_i64(i).into_value())
            } else {
                Ok(ruby.float_from_f64(n.as_f64().unwrap_or(0.0)).into_value())
            }
        }
        Wire::String(s) => Ok(ruby.str_new(s).as_value()),
        Wire::Array(items) => {
            let array = ruby.ary_new_capa(items.len());
            for item in items {
                array.push(value_to_ruby(ruby, cache, item)?)?;
            }
            Ok(array.as_value())
        }
        Wire::Object(map) => {
            let class_name = map.get("_class").and_then(Wire::as_str).ok_or_else(|| {
                Error::new(
                    ruby.exception_runtime_error(),
                    "expressir-core: model node without _class",
                )
            })?;
            let klass = cache.resolve(ruby, class_name)?;
            let attrs = RHash::new();
            for (key, item) in map {
                attrs.aset(ruby.str_new(key), value_to_ruby(ruby, cache, item)?)?;
            }
            klass.funcall::<_, _, magnus::Value>("instantiate", (attrs,))
        }
    }
}

fn model_object(ruby: &Ruby, source: String, path: String) -> Result<magnus::Value, Error> {
    let tree = ParsedTree::parse(&source).map_err(|e| {
        Error::new(
            ruby.exception_runtime_error(),
            format!("expressir-core: parse error: {e:?}"),
        )
    })?;
    let wire = tree.to_model_json(&path).map_err(|e| parse_error(ruby, e))?;
    let mut cache = ClassCache::default();
    value_to_ruby(ruby, &mut cache, &wire)
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("Expressir")?.define_module("Core")?;
    module.define_singleton_method("parse_to_model_hash", function!(model_json, 2))?;
    module.define_singleton_method("parse_to_model", function!(model_object, 2))?;
    Ok(())
}
