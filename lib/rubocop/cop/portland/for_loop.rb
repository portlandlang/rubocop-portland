# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no `for`: `each` is the one loop over a collection
      # (portland's docs/ruby/removed-syntax.md). A taste difference, and a
      # mechanical rewrite — the loop's head becomes `collection.each do
      # |variables|`, and the body and `end` stay as they are.
      #
      # @safety
      #   A `for` loop's variables outlive the loop, and a block's
      #   parameters don't, so code reading the variable after the loop
      #   changes meaning. Portland refuses that read rather than letting it
      #   run, so the rewrite is safe to try and loud when it isn't.
      #
      # @example
      #   # bad
      #   for word in words
      #     puts word
      #   end
      #
      #   # good
      #   words.each do |word|
      #     puts word
      #   end
      class ForLoop < Base
        extend AutoCorrector

        MSG = 'Portland has no `for` — iterate with `each`.'

        def on_for(node)
          head = head_range(node)
          add_offense(head) do |corrector|
            corrector.replace(head, "#{receiver_source(node.collection)}.each do |#{node.variable.source}|")
          end
        end

        private

        # From `for` through the collection, and the `do` if one is written.
        def head_range(node)
          last = node.loc.begin || node.collection.source_range
          node.loc.keyword.join(last)
        end

        # A range or an operator expression needs parentheses before `.each`.
        def receiver_source(collection)
          needs_parentheses = collection.range_type? || collection.operator_keyword? ||
                              (collection.send_type? && collection.operator_method?)
          needs_parentheses ? "(#{collection.source})" : collection.source
        end
      end
    end
  end
end
