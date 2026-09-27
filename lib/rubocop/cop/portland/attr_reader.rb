# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # A Portland type lists its fields bare, one per line; whether
      # `attr_reader :name` becomes a second spelling of that list is
      # portland#134's question. A taste difference, undecided.
      #
      # @example
      #   # bad (for now)
      #   class Point
      #     attr_reader :x, :y
      #   end
      #
      #   # good
      #   class Point
      #     x
      #     y
      #   end
      class AttrReader < Base
        MSG = 'Portland lists fields bare, one per line — `attr_reader` as a spelling of that is portland#134.'
        RESTRICT_ON_SEND = %i[attr_reader].freeze

        def on_send(node)
          return unless node.receiver.nil?

          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
