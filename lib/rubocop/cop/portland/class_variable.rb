# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no class variables: shared mutable state is what the
      # language exists to avoid (portland's ADR 0056, docs/ruby/classes.md).
      # A thesis difference, and Portland refuses `@@total` naming where a
      # value lives instead.
      #
      # @example
      #   # bad
      #   @@total = 0
      #
      #   # good
      #   TOTAL = 0   # when it never changes
      class ClassVariable < Base
        MSG = 'Portland has no class variables — a value lives in a local, a field, or a constant.'

        def on_cvar(node)
          add_offense(node)
        end

        def on_cvasgn(node)
          add_offense(node.loc.name)
        end
      end
    end
  end
end
