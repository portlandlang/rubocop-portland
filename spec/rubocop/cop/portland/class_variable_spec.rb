# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::ClassVariable, :config do
  it 'reports a class variable read and written' do
    expect_offense(<<~RUBY)
      class Counter
        @@total = 0
        ^^^^^^^ Portland has no class variables — a value lives in a local, a field, or a constant.
        def total = @@total
                    ^^^^^^^ Portland has no class variables — a value lives in a local, a field, or a constant.
      end
    RUBY
  end

  it 'leaves a constant alone' do
    expect_no_offenses(<<~RUBY)
      class Counter
        TOTAL = 0
      end
    RUBY
  end
end
