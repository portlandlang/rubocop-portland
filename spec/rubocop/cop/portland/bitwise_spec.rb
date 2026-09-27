# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Bitwise, :config do
  it 'reports the bitwise operators' do
    expect_offense(<<~RUBY)
      flags = read | write
                   ^ Portland leans toward named methods over `|` (ADR 0003, tentative).
      half = count >> 1
                   ^^ Portland leans toward named methods over `>>` (ADR 0003, tentative).
    RUBY
  end

  it 'leaves the logical operators and the append operator alone' do
    expect_no_offenses(<<~RUBY)
      ready = read || write
      words << word
    RUBY
  end
end
