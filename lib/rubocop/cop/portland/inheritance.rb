# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no inheritance: `class` is a spelling of `struct`
      # (portland's ADR 0056), and shared behavior lives in a trait the type
      # includes (ADR 0028, docs/ruby/mixins-and-inheritance.md). Portland
      # refuses `class Token < Node` naming the trait rewrite, and `super`
      # with it; the cop reports both.
      #
      # @example
      #   # bad
      #   class Token < Node
      #   end
      #
      #   # good
      #   class Token
      #     include Named
      #   end
      class Inheritance < Base
        MSG = 'Portland has no inheritance — move the parent\'s shared methods into a trait and `include` it.'
        SUPER_MSG = 'Portland has no inheritance, so no `super` — ' \
                    'call the trait\'s method, or `fields(...)` in `def self.new`.'

        def on_class(node)
          return unless node.parent_class

          add_offense(node.loc.operator.join(node.parent_class.source_range))
        end

        def on_super(node)
          add_offense(node.loc.keyword, message: SUPER_MSG)
        end

        def on_zsuper(node)
          add_offense(node, message: SUPER_MSG)
        end
      end
    end
  end
end
