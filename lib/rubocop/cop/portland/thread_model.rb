# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Portland has one concurrency model, `together` and its task lines,
      # in place of Ruby's threads, fibers, ractors, mutexes, and queues
      # (portland's ADR 0029, docs/ruby/concurrency.md). A thesis difference.
      #
      # @example
      #   # bad
      #   threads = urls.map { |url| Thread.new { fetch(url) } }
      #
      #   # good (Portland)
      #   together do
      #     ~ first = fetch(first_url)
      #     ~ second = fetch(second_url)
      #   end
      class ThreadModel < Base
        MSG = 'Portland has no `%<name>s` — concurrency is `together` and its task lines.'
        NAMES = %i[Fiber Mutex Queue Ractor Thread].freeze

        def on_const(node)
          return unless node.namespace.nil? || node.namespace.cbase_type?
          return unless NAMES.include?(node.short_name)

          add_offense(node, message: format(MSG, name: node.short_name))
        end
      end
    end
  end
end
