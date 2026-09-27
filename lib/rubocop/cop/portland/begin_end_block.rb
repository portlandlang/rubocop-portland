# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no `BEGIN { }` or `END { }` blocks, the perlisms
      # portland's docs/ruby/removed-syntax.md deletes. A taste difference.
      #
      # @example
      #   # bad
      #   END { puts "done" }
      #
      #   # good
      #   puts "done"   # at the end of the program
      class BeginEndBlock < Base
        MSG = 'Portland has no `BEGIN` or `END` blocks — run the code where the program starts or ends.'

        def on_preexe(node)
          add_offense(node.loc.keyword)
        end

        def on_postexe(node)
          add_offense(node.loc.keyword)
        end
      end
    end
  end
end
