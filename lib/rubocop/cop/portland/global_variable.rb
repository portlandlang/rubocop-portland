# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no global variables, nor the special-variable zoo
      # (`$0`, `$~`, `$1`): portland's docs/ruby/removed-syntax.md. A taste
      # difference; where the value lives instead depends on the program, so
      # the cop reports and doesn't rewrite.
      #
      # @example
      #   # bad
      #   $count = 0
      #   puts $stdout
      #
      #   # good
      #   count = 0
      class GlobalVariable < Base
        MSG = 'Portland has no global variables — keep the value in a local, a constant, or a field.'

        def on_gvar(node)
          add_offense(node)
        end

        def on_gvasgn(node)
          add_offense(node.loc.name)
        end

        def on_nth_ref(node)
          add_offense(node)
        end

        def on_back_ref(node)
          add_offense(node)
        end
      end
    end
  end
end
