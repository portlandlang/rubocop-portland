# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::AttrReader, :config do
  it 'reports attr_reader' do
    expect_offense(<<~RUBY)
      class Point
        attr_reader :x, :y
        ^^^^^^^^^^^ Portland lists fields bare, one per line — `attr_reader` as a spelling of that is portland#134.
      end
    RUBY
  end

  it 'leaves an attr_reader method on a receiver alone' do
    expect_no_offenses(<<~RUBY)
      builder.attr_reader
    RUBY
  end
end
