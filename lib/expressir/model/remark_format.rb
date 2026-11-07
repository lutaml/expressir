# frozen_string_literal: true

module Expressir
  module Model
    # Single source of truth for the remark-format vocabulary.
    #
    # Reference: ISO 10303-11 §7.1.6 defines exactly two remark forms:
    # the tail remark (`-- ... \n`) and the embedded remark (`(* ... *)`).
    # Both the model (RemarkInfo) and the express-side scanner/attacher
    # reference these constants instead of bare string literals, so a
    # rename or extension lands in one place.
    module RemarkFormat
      TAIL = "tail"
      EMBEDDED = "embedded"

      # EXPRESSdoc annotations (metanorma/annotated-express#94): the
      # display channel, parsed only in annotations mode. `---` tail
      # annotations take exactly three dashes; `(** ... *)` embedded
      # annotations close with the remark closer.
      TAIL_ANNOTATION = "tail_annotation"
      EMBEDDED_ANNOTATION = "embedded_annotation"
    end
  end
end
