# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Assigning an instance variable is mutable object state, which has no
      # Portland home yet: portland#103 is deciding it. A thesis difference,
      # undecided. Assignments inside `initialize` move to `def self.new`
      # with `fields(...)` (portland's docs/ruby/classes.md); the rest wait on
      # #103.
      #
      # @example
      #   # bad
      #   def advance! = @position += 1
      class InstanceVariableWrite < Base
        MSG = 'Portland has no instance state yet (portland#103) — in `initialize`, move it to `def self.new` ' \
              'with `fields(...)`.'

        def on_ivasgn(node)
          add_offense(node.loc.name)
        end
      end
    end
  end
end
