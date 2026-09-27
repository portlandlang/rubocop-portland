# frozen_string_literal: true

require 'lint_roller'

module RuboCop
  module Portland
    # A plugin that integrates rubocop-portland with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: 'rubocop-portland',
          version: VERSION,
          homepage: 'https://github.com/portlandlang/rubocop-portland',
          description: "The migration linter for Portland: a cop for each Ruby difference the language's ledger names."
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join('../../../config/default.yml')
        )
      end
    end
  end
end
