# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Regex literals and matching wait on portland#74. A gap, undecided —
      # and a bigger one than it looks: Portland's lexer reads a regex's `/`
      # as division, so most regexes refuse at their first backslash.
      #
      # @example
      #   # bad (for now)
      #   words = text.scan(/\w+/)
      #   puts "match" if line =~ /\Aend\z/
      class Regex < Base
        MSG = 'Portland has no regex yet (portland#74) — match with string methods, or wait for the decision.'
        MATCH_MSG = 'Portland has no `=~` or match variables yet (portland#74).'

        def on_regexp(node)
          add_offense(node)
        end

        def on_match_with_lvasgn(node)
          add_offense(node.loc.selector, message: MATCH_MSG)
        end
      end
    end
  end
end
