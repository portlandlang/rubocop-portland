# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland leans toward taking the bitwise operators — `&`, `|`, `^`,
      # `~`, `>>` — out of the grammar in favor of named methods (portland's
      # ADR 0003, tentative). A taste difference, undecided. `<<` stays: it is
      # the append operator (ADR 0015).
      #
      # @example
      #   # bad (for now)
      #   flags = read | write
      class Bitwise < Base
        MSG = 'Portland leans toward named methods over `%<name>s` (ADR 0003, tentative).'
        RESTRICT_ON_SEND = %i[& | ^ ~ >>].freeze

        def on_send(node)
          add_offense(node.loc.selector, message: format(MSG, name: node.method_name))
        end
        alias on_csend on_send
      end
    end
  end
end
