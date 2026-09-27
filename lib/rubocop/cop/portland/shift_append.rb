# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # `<<` stays in Portland, but as rebinding: `words << word` means
      # `words = words + [word]`, so the name needs a `mutable` binding, and
      # anything else holding the old array keeps the old array (portland's
      # ADR 0015). A thesis difference: the spelling survives, the aliasing
      # doesn't. Off by default, since the line itself usually ports as is.
      #
      # @example
      #   # Portland
      #   mutable words = []
      #   words << word
      class ShiftAppend < Base
        MSG = 'In Portland, `<<` rebinds the name — declare it `mutable`; other holders keep the old value.'
        RESTRICT_ON_SEND = %i[<<].freeze

        def on_send(node)
          return if node.receiver.nil?

          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
