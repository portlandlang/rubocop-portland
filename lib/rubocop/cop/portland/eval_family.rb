# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland's runtime is closed: no code is evaluated from a string, no
      # block runs as another object, and no method is called or instance
      # variable reached by name (portland's docs/ruby/metaprogramming.md).
      # A thesis difference.
      #
      # @example
      #   # bad
      #   receiver.send(name, value)
      #   config.instance_eval(&block)
      #
      #   # good
      #   receiver.update(value)
      class EvalFamily < Base
        MSG = 'Portland has no `%<name>s` — the runtime is closed; call the method you mean by name.'
        RESTRICT_ON_SEND = %i[
          __send__ class_eval class_exec eval instance_eval instance_exec
          instance_variable_get instance_variable_set module_eval public_send send
        ].freeze

        def on_send(node)
          add_offense(node.loc.selector, message: format(MSG, name: node.method_name))
        end
        alias on_csend on_send
      end
    end
  end
end
