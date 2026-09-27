# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::InstanceVariableWrite, :config do
  it 'reports an instance variable assignment and a compound one' do
    expect_offense(<<~RUBY)
      def initialize(text)
        @text = text
        ^^^^^ Portland has no instance state yet (portland#103) — in `initialize`, move it to `def self.new` with `fields(...)`.
      end
      def advance! = @position += 1
                     ^^^^^^^^^ Portland has no instance state yet (portland#103) — in `initialize`, move it to `def self.new` with `fields(...)`.
    RUBY
  end

  it 'leaves a local alone' do
    expect_no_offenses(<<~RUBY)
      position = 1
    RUBY
  end
end
