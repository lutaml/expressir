//! Fixture parity tests: the extracted declaration-level model must
//! match the expected JSON generated from the real Expressir model
//! (`generate/expected_model.rb`).

use expressir_core::ParsedTree;
use serde_json::Value;

fn check(name: &str) {
    let dir = concat!(env!("CARGO_MANIFEST_DIR"), "/tests/fixtures");
    let source = std::fs::read_to_string(format!("{dir}/{name}.exp"))
        .unwrap_or_else(|e| panic!("read {name}.exp: {e}"));
    let expected_text = std::fs::read_to_string(format!("{dir}/{name}.json"))
        .unwrap_or_else(|e| panic!("read {name}.json: {e}"));
    let expected: Value =
        serde_json::from_str(&expected_text).unwrap_or_else(|e| panic!("parse {name}.json: {e}"));

    let tree = ParsedTree::parse(&source).unwrap_or_else(|e| panic!("parse {name}.exp: {e:?}"));
    let actual = serde_json::to_value(tree.to_model()).expect("serialize model");

    assert_eq!(actual, expected, "model mismatch for fixture {name}");
}

macro_rules! fixture {
    ($test_name:ident, $name:literal) => {
        #[test]
        fn $test_name() {
            check($name);
        }
    };
}

fixture!(multiple, "multiple");
fixture!(single, "single");
fixture!(derived_attribute, "derived_attribute");
fixture!(geometry_schema, "geometry_schema");
fixture!(syntax, "syntax");
fixture!(remark, "remark");
fixture!(test_generic, "test-generic");
fixture!(without_ending_newline, "without_ending_newline");
