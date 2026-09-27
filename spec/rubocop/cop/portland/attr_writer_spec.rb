# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::AttrWriter, :config do
  it 'reports attr_accessor and attr_writer' do
    expect_offense(<<~RUBY)
      class Point
        attr_accessor :x
        ^^^^^^^^^^^^^ Portland has no setters yet (portland#103) — a changed value is `record.with(field: value)`.
        attr_writer :y
        ^^^^^^^^^^^ Portland has no setters yet (portland#103) — a changed value is `record.with(field: value)`.
      end
    RUBY
  end

  it 'leaves attr_reader to its own cop' do
    expect_no_offenses(<<~RUBY)
      class Point
        attr_reader :x
      end
    RUBY
  end
end
