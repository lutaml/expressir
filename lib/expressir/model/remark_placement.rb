# frozen_string_literal: true

module Expressir
  module Model
    # Single source of truth for where a remark sits relative to the model
    # element that owns it.
    #
    # The parser discards comments, so attachment reconstructs their position
    # from source lines. Placement records that reconstruction, letting the
    # formatter put the remark back where it was written:
    #
    # - LEADING — on its own line(s) directly above the owning statement.
    # - TRAILING — on its own line(s) at the end of a body, before the closing
    #   keyword. The owner is the body's owner, and RemarkInfo#region names
    #   which body: an IF owns two, and they close at different keywords.
    # - INLINE — on the same line as the owning statement, after its text.
    #   Only single-line statements take these: appending to a multi-line
    #   statement would move the remark down to its closing keyword.
    #
    # `nil` means the remark was attached by a legacy path, or predates
    # placement tracking. Those keep their historical emission and must not
    # be rendered by placement-aware emitters.
    module RemarkPlacement
      LEADING = "leading"
      TRAILING = "trailing"
      INLINE = "inline"
    end
  end
end
