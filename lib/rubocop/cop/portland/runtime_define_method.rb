# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland's runtime is closed: methods and constants aren't made or
      # looked up by name while the program runs (portland's
      # docs/ruby/metaprogramming.md). A thesis difference; compile-time
      # macros are the planned replacement.
      #
      # @example
      #   # bad
      #   %i[small large].each { |size| define_method("#{size}?") { self.size == size } }
      #   Object.const_get(name)
      #
      #   # good
      #   def small? = size == :small
      #   def large? = size == :large
      class RuntimeDefineMethod < Base
        MSG = 'Portland makes no methods or constants at runtime — write them out, or generate them at compile time.'
        RESTRICT_ON_SEND = %i[const_get const_set define_method].freeze

        def on_send(node)
          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
