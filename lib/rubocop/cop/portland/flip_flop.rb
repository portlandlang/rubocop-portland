# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no flip-flops — a range in a condition that toggles —
      # which portland's docs/ruby/removed-syntax.md deletes. A taste
      # difference.
      #
      # @example
      #   # bad
      #   lines.each { |line| puts line if line.start_with?("BEGIN")..line.start_with?("END") }
      class FlipFlop < Base
        MSG = 'Portland has no flip-flops — track the toggle in a `mutable` local.'

        def on_iflipflop(node)
          add_offense(node)
        end

        def on_eflipflop(node)
          add_offense(node)
        end
      end
    end
  end
end
