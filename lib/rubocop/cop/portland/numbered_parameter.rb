# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no numbered block parameters: `it` is the one implicit
      # parameter (portland's ADR 0017). A taste difference, and a mechanical
      # rewrite when a block uses only `_1` — it becomes `it`. A block using
      # `_2` or beyond needs named parameters, so the cop reports it and
      # leaves the rewrite to a person.
      #
      # @example
      #   # bad
      #   words.map { _1.upcase }
      #
      #   # good
      #   words.map { it.upcase }
      class NumberedParameter < Base
        extend AutoCorrector

        MSG = 'Portland has no `_1` — `it` is the one implicit block parameter.'
        NAMED_MSG = 'Portland has no numbered block parameters — name them: `{ |first, second| ... }`.'

        def on_numblock(node)
          if node.children[1] == 1
            node.each_descendant(:lvar).select { it.children.first == :_1 }.each do |reference|
              add_offense(reference) { |corrector| corrector.replace(reference, 'it') }
            end
          else
            add_offense(node.send_node, message: NAMED_MSG)
          end
        end
      end
    end
  end
end
