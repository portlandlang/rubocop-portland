# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::MethodMissing, :config do
  it 'reports method_missing and respond_to_missing?' do
    expect_offense(<<~RUBY)
      def method_missing(name)
      ^^^^^^^^^^^^^^^^^^ Portland has no `method_missing` — define each method, or generate them at compile time.
        name
      end
      def respond_to_missing?(name, private) = true
      ^^^^^^^^^^^^^^^^^^^^^^^ Portland has no `method_missing` — define each method, or generate them at compile time.
    RUBY
  end

  it 'leaves ordinary methods alone' do
    expect_no_offenses(<<~RUBY)
      def missing = true
    RUBY
  end
end
