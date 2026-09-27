# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Visibility — `private`, `protected`, `public` — isn't designed in
      # Portland yet: portland#133 is deciding it, and until then a type body
      # refuses the words rather than reading them as fields. A gap,
      # undecided.
      #
      # @example
      #   # bad (for now)
      #   class Box
      #     private
      #
      #     def secret = 1
      #   end
      class Visibility < Base
        MSG = 'Portland has no `%<name>s` yet — visibility is undecided (portland#133).'
        RESTRICT_ON_SEND = %i[module_function private private_class_method private_constant protected public].freeze

        def on_send(node)
          return unless node.receiver.nil?

          add_offense(node.loc.selector, message: format(MSG, name: node.method_name))
        end
        alias on_csend on_send
      end
    end
  end
end
