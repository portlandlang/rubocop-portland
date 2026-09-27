# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Once values never mutate (portland's ADR 0015), `freeze`, `frozen?`,
      # `dup`, and `clone` have nothing to do, and Portland refuses them as
      # missing methods. A thesis difference; delete the call, keeping the
      # receiver.
      #
      # @example
      #   # bad
      #   LABELS = %w[low high].freeze
      #   copy = original.dup
      #
      #   # good (Portland)
      #   LABELS = %w[low high]
      #   copy = original
      class FreezeFamily < Base
        MSG = 'Portland values never mutate, so `%<name>s` has nothing to do — drop the call.'
        RESTRICT_ON_SEND = %i[clone dup freeze frozen?].freeze

        def on_send(node)
          return if node.receiver.nil?

          add_offense(node.loc.selector, message: format(MSG, name: node.method_name))
        end
        alias on_csend on_send
      end
    end
  end
end
