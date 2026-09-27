# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Splat, :config do
  it 'reports splat parameters and splatted arguments' do
    expect_offense(<<~RUBY)
      def log(*messages, **options) = write(*messages, **options)
              ^^^^^^^^^ Portland defers splats (ADR 0014) — take an array or keyword arguments.
                         ^^^^^^^^^ Portland defers splats (ADR 0014) — take an array or keyword arguments.
                                            ^^^^^^^^^ Portland defers splats (ADR 0014) — take an array or keyword arguments.
                                                       ^^^^^^^^^ Portland defers splats (ADR 0014) — take an array or keyword arguments.
    RUBY
  end

  it 'leaves plain and keyword parameters alone' do
    expect_no_offenses(<<~RUBY)
      def log(messages, level: :info) = write(messages, level: level)
    RUBY
  end
end
