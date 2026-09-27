# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has no `class << self`: each function on the type is written
      # `def self.name` in the type's body (portland's ADR 0056,
      # docs/ruby/classes.md). A taste difference.
      #
      # @example
      #   # bad
      #   class Token
      #     class << self
      #       def build = new
      #     end
      #   end
      #
      #   # good
      #   class Token
      #     def self.build = new
      #   end
      class SingletonClass < Base
        MSG = 'Portland has no `class << self` — write each method as `def self.name` in the type\'s body.'

        def on_sclass(node)
          add_offense(node.loc.keyword.join(node.identifier.source_range))
        end
      end
    end
  end
end
