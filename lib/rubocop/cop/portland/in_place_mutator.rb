# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Values never mutate in Portland; names do (portland's ADR 0015,
      # docs/ruby/mutability.md). So the in-place mutators don't exist:
      # `list.push(x)` becomes `list << x` on a `mutable` name, and
      # `text.upcase!` becomes `text = text.upcase`. A thesis difference.
      # Whether a bang method becomes rebinding sugar is portland#103's
      # question.
      #
      # Matching is by method name, blind to the receiver, so a program's
      # own `push` on its own type is reported too.
      #
      # @example
      #   # bad
      #   words.push(word)
      #   title.upcase!
      #
      #   # good (Portland)
      #   words << word      # with `mutable words`
      #   title = title.upcase
      class InPlaceMutator < Base
        MSG = 'Portland values never mutate — `%<name>s` has no Portland meaning; rebind the name to a new value.'
        RESTRICT_ON_SEND = %i[
          append clear compact! concat delete_at delete_if downcase! flatten! gsub! insert map! merge! pop push
          reject! replace reverse! select! shift sort! squeeze! strip! sub! uniq! unshift upcase!
        ].freeze

        def on_send(node)
          return if node.receiver.nil?

          add_offense(node.loc.selector, message: format(MSG, name: node.method_name))
        end
        alias on_csend on_send
      end
    end
  end
end
