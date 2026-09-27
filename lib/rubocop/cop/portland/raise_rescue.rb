# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no exceptions: a fallible operation returns its value or
      # a `failure`, and the caller handles it with the toolkit it already
      # uses for absence (portland's ADR 0027, docs/ruby/errors.md). A thesis
      # difference, so the cop reports `raise`, `fail`, `rescue`, `ensure`,
      # and `retry`, and rewrites none of them.
      #
      # @example
      #   # bad
      #   raise ArgumentError, "empty" if text.empty?
      #
      #   # good
      #   return failure("empty") if text.empty?
      class RaiseRescue < Base
        RAISE_MSG = 'Portland has no exceptions — return a `failure("why")` instead.'
        RESCUE_MSG = 'Portland has no exceptions to rescue — ' \
                     'handle the returned failure with `or`, `case/in`, or `failure?`.'
        RESTRICT_ON_SEND = %i[raise fail].freeze

        def on_send(node)
          return unless node.receiver.nil?

          add_offense(node.loc.selector, message: RAISE_MSG)
        end
        alias on_csend on_send

        def on_resbody(node)
          add_offense(node.loc.keyword, message: RESCUE_MSG)
        end

        def on_ensure(node)
          add_offense(node.loc.keyword, message: RESCUE_MSG)
        end

        def on_retry(node)
          add_offense(node, message: RESCUE_MSG)
        end
      end
    end
  end
end
