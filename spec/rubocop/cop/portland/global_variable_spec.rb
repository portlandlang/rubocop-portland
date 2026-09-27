# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::GlobalVariable, :config do
  it 'reports a global variable read and written' do
    expect_offense(<<~RUBY)
      $count = 0
      ^^^^^^ Portland has no global variables — keep the value in a local, a constant, or a field.
      puts $count
           ^^^^^^ Portland has no global variables — keep the value in a local, a constant, or a field.
    RUBY
  end

  it 'reports the match specials' do
    expect_offense(<<~RUBY)
      puts $1
           ^^ Portland has no global variables — keep the value in a local, a constant, or a field.
      puts $~
           ^^ Portland has no global variables — keep the value in a local, a constant, or a field.
    RUBY
  end

  it 'leaves locals alone' do
    expect_no_offenses(<<~RUBY)
      count = 0
      puts count
    RUBY
  end
end
