# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::RuntimeDefineMethod, :config do
  it 'reports define_method, const_get, and const_set' do
    expect_offense(<<~RUBY)
      define_method(:large?) { true }
      ^^^^^^^^^^^^^ Portland makes no methods or constants at runtime — write them out, or generate them at compile time.
      Object.const_get(name)
             ^^^^^^^^^ Portland makes no methods or constants at runtime — write them out, or generate them at compile time.
      Object.const_set(:LIMIT, 3)
             ^^^^^^^^^ Portland makes no methods or constants at runtime — write them out, or generate them at compile time.
    RUBY
  end

  it 'leaves an ordinary def alone' do
    expect_no_offenses(<<~RUBY)
      def large? = true
    RUBY
  end
end
