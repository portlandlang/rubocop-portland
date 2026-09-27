# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland's runtime is closed: no call reaches a method that isn't
      # defined, so `method_missing` and `respond_to_missing?` have nothing to
      # catch (portland's docs/ruby/metaprogramming.md). A thesis difference;
      # compile-time macros are the planned replacement.
      #
      # @example
      #   # bad
      #   def method_missing(name, *arguments)
      #     settings.fetch(name) { super }
      #   end
      class MethodMissing < Base
        MSG = 'Portland has no `method_missing` — define each method, or generate them at compile time.'

        def on_def(node)
          return unless %i[method_missing respond_to_missing?].include?(node.method_name)

          add_offense(node.loc.keyword.join(node.loc.name))
        end
      end
    end
  end
end
