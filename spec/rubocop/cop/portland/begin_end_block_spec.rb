# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::BeginEndBlock, :config do
  it 'reports BEGIN and END blocks' do
    expect_offense(<<~RUBY)
      BEGIN { puts "start" }
      ^^^^^ Portland has no `BEGIN` or `END` blocks — run the code where the program starts or ends.
      END { puts "done" }
      ^^^ Portland has no `BEGIN` or `END` blocks — run the code where the program starts or ends.
    RUBY
  end

  it 'leaves begin/end alone' do
    expect_no_offenses(<<~RUBY)
      puts "done"
    RUBY
  end
end
