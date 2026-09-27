# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::NumberedParameter, :config do
  it 'rewrites a lone _1 to it' do
    expect_offense(<<~RUBY)
      words.map { _1.upcase }
                  ^^ Portland has no `_1` — `it` is the one implicit block parameter.
    RUBY

    expect_correction(<<~RUBY)
      words.map { it.upcase }
    RUBY
  end

  it 'reports a block using _2 without rewriting it' do
    expect_offense(<<~RUBY)
      pairs.map { _1 + _2 }
      ^^^^^^^^^ Portland has no numbered block parameters — name them: `{ |first, second| ... }`.
    RUBY

    expect_no_corrections
  end

  it 'leaves it alone' do
    expect_no_offenses(<<~RUBY)
      words.map { it.upcase }
    RUBY
  end
end
