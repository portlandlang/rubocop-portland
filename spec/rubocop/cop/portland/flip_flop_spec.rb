# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::FlipFlop, :config do
  it 'reports a flip-flop in a condition' do
    expect_offense(<<~RUBY)
      puts line if (line == "a")..(line == "b")
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Portland has no flip-flops — track the toggle in a `mutable` local.
    RUBY
  end

  it 'leaves a range alone' do
    expect_no_offenses(<<~RUBY)
      numbers = (1..3).to_a
    RUBY
  end
end
