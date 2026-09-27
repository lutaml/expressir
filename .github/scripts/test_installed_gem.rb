# frozen_string_literal: true

# Smoke test for an INSTALLED expressir gem (run after `gem install`,
# never from the source directory): the Rust core binding must be
# active and the parser must handle the standard and #462 forms.
require "expressir"

abort "FAIL: NATIVE_AVAILABLE is false" unless Expressir::Express::Core::NATIVE_AVAILABLE
puts "native binding: active"

repo = Expressir::Express::Parser.from_exp(
  "SCHEMA smoke; ENTITY e; a : STRING; END_ENTITY; END_SCHEMA;",
)
abort "FAIL: schema not parsed" unless repo.schemas.first.id == "smoke"
puts "standard parse: ok"

src = <<~EXP
  SCHEMA m;
  ENTITY e; END_ENTITY;
  SUBTYPE_CONSTRAINT c FOR e;
    ABSTRACT;
  END_SUBTYPE_CONSTRAINT;
  END_SCHEMA;
EXP
sc = Expressir::Express::Parser.from_exp(src).schemas.first.subtype_constraints.first
abort "FAIL: subtype constraint ABSTRACT body (#462)" unless sc&.abstract == true
puts "#462 form: ok"

puts "SMOKE OK"
