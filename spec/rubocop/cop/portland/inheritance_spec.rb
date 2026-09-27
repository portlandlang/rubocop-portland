# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Inheritance, :config do
  it 'reports a class that inherits' do
    expect_offense(<<~RUBY)
      class Token < Node
                  ^^^^^^ Portland has no inheritance — move the parent's shared methods into a trait and `include` it.
      end
    RUBY
  end

  it 'reports super, with or without arguments' do
    expect_offense(<<~RUBY)
      def initialize(text)
        super(text)
        ^^^^^ Portland has no inheritance, so no `super` — call the trait's method, or `fields(...)` in `def self.new`.
        super
        ^^^^^ Portland has no inheritance, so no `super` — call the trait's method, or `fields(...)` in `def self.new`.
      end
    RUBY
  end

  it 'leaves a class with no parent alone' do
    expect_no_offenses(<<~RUBY)
      class Token
      end
    RUBY
  end
end
