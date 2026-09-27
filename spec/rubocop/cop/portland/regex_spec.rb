# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Regex, :config do
  it 'reports a regex literal' do
    expect_offense(<<~'RUBY')
      words = text.scan(/\w+/)
                        ^^^^^ Portland has no regex yet (portland#74) — match with string methods, or wait for the decision.
    RUBY
  end

  it 'leaves string methods alone' do
    expect_no_offenses(<<~RUBY)
      words = text.split
    RUBY
  end
end
