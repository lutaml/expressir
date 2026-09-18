//! Rust core for Expressir: parses EXPRESS schemas through the parsanol
//! engine (grammar embedded as the JSON the Ruby tier serializes) and
//! builds the declaration-level model skeleton.
//!
//! Phase 1 scope (TODO.max-perf/9): the grammar is loaded once, parses
//! run on the packrat engine, and the walk extracts declarations —
//! schema name/version, entities (with explicit attributes and WHERE
//! labels), types, functions, procedures, rules, and constants.
//! Subsequent phases deepen the model and move remark attachment.

pub mod extract;
pub mod model;
pub mod walk;

pub use extract::extract_file;
pub use model::*;

use std::sync::OnceLock;

use parsanol::portable::to_parslet_compatible;
use parsanol::portable::{AstArena, Grammar, PortableParser};

/// The EXPRESS grammar as serialized by the Ruby tier
/// (`Parsanol::Native::Parser.grammar_json`). Regenerate with
/// `bundle exec rake expressir:grammar:dump`.
const EXPRESS_GRAMMAR_JSON: &str = include_str!("../assets/express-grammar.json");

fn grammar() -> &'static Grammar {
    static GRAMMAR: OnceLock<Grammar> = OnceLock::new();
    GRAMMAR.get_or_init(|| {
        Grammar::from_json(EXPRESS_GRAMMAR_JSON).expect("embedded EXPRESS grammar is valid")
    })
}

/// Parse `source` and return the parslet-shaped AST root plus the
/// arena it lives in. The raw tagged tree (`:sequence`/`:repetition`
/// arrays) is normalized with `to_parslet_compatible`, so the root
/// matches the tree Expressir's Ruby tier hydrates: single-key
/// camelCase rule hashes, arrays for repetitions, input refs for
/// strings. The arena owns the interned strings and the original
/// input; the tree and any extracted model borrow from it.
pub struct ParsedTree {
    arena: Box<AstArena>,
    root: parsanol::portable::AstNode,
    _grammar: &'static Grammar,
}

impl ParsedTree {
    pub fn parse(source: &str) -> Result<Self, parsanol::portable::ParseError> {
        let grammar = grammar();
        let mut arena = Box::new(AstArena::for_input(source.len()));
        arena.set_input(source.to_string());
        let mut parser = PortableParser::new(grammar, source, &mut arena);
        let raw = parser.parse()?;
        let root = to_parslet_compatible(&raw, arena.as_mut(), source);
        Ok(Self {
            arena,
            root,
            _grammar: grammar,
        })
    }

    pub fn root(&self) -> &parsanol::portable::AstNode {
        &self.root
    }

    pub fn arena(&self) -> &AstArena {
        &self.arena
    }

    /// Extract the declaration-level model from this tree.
    pub fn to_model(&self) -> Repository {
        extract_file(self)
    }
}
