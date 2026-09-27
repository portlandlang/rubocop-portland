# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland resolves `require_relative` today, but `require "name"`, a
      # load path, and stdlib names are portland#116's question. A gap,
      # undecided — and the census's biggest: it's the only open question for
      # tens of thousands of gems.
      #
      # @example
      #   # bad (for now)
      #   require "json"
      #   require "my_gem/version"
      #
      #   # good
      #   require_relative "my_gem/version"
      class RequireByName < Base
        MSG = 'Portland has no `require` by name yet (portland#116) — `require_relative` resolves today.'
        RESTRICT_ON_SEND = %i[require].freeze

        def on_send(node)
          return unless node.receiver.nil?

          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
