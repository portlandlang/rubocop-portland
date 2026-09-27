# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # `attr_writer` and `attr_accessor` generate setters, which mutate an
      # object in place; that has no Portland home yet (portland#103). A
      # thesis difference, undecided. Until #103 decides, a type's value
      # changes by `with`: `point.with(x: 3)`.
      #
      # @example
      #   # bad
      #   attr_accessor :name
      class AttrWriter < Base
        MSG = 'Portland has no setters yet (portland#103) — a changed value is `record.with(field: value)`.'
        RESTRICT_ON_SEND = %i[attr_accessor attr_writer].freeze

        def on_send(node)
          return unless node.receiver.nil?

          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
