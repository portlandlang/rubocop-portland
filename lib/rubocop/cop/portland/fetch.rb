# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland retires `fetch`: a lookup that can miss answers a maybe, and
      # `hash[key] or default` says what `fetch(key, default)` said
      # (portland's ADR 0010, docs/ruby/lookups.md). A taste difference.
      # The cop reports rather than rewrites, since `or` binds looser than
      # `=` in Ruby, so the rewrite reads differently in the two languages.
      #
      # @example
      #   # bad
      #   port = settings.fetch(:port, 3000)
      #
      #   # good (Portland)
      #   port = settings[:port] or 3000
      class Fetch < Base
        MSG = 'Portland retires `fetch` — write `collection[key] or default`, or handle the missing key.'
        RESTRICT_ON_SEND = %i[fetch].freeze

        def on_send(node)
          return if node.receiver.nil?

          add_offense(node.loc.selector)
        end
        alias on_csend on_send
      end
    end
  end
end
