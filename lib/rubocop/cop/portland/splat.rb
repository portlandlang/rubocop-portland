# frozen_string_literal: true

module RuboCop
  module Cop
    module Portland
      # Splats — `*arguments`, `**options` — are deferred in Portland
      # (portland's ADR 0014): keyword arguments are Ruby 3's, and splats wait
      # on a real file pulling for them. A gap, undecided.
      #
      # @example
      #   # bad (for now)
      #   def log(*messages) = messages.each { puts it }
      #
      #   # good
      #   def log(messages) = messages.each { puts it }
      class Splat < Base
        MSG = 'Portland defers splats (ADR 0014) — take an array or keyword arguments.'

        def on_restarg(node)
          add_offense(node)
        end

        def on_kwrestarg(node)
          add_offense(node)
        end

        def on_splat(node)
          add_offense(node)
        end

        def on_kwsplat(node)
          add_offense(node)
        end
      end
    end
  end
end
