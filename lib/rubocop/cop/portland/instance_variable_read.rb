# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # A Portland type's fields are read by their bare names: `class` is a
      # spelling of `struct` (portland's ADR 0056), and `@text` refuses,
      # naming `text`. A taste difference; the rewrite is mechanical once the
      # field is declared, which is a person's edit, so the cop reports.
      #
      # @example
      #   # bad
      #   def label = "#{@name} (#{@size})"
      #
      #   # good (Portland)
      #   def label = "#{name} (#{size})"
      class InstanceVariableRead < Base
        MSG = 'Portland reads a field by its bare name — write `%<name>s`.'

        def on_ivar(node)
          add_offense(node, message: format(MSG, name: node.children.first.to_s.delete_prefix('@')))
        end
      end
    end
  end
end
