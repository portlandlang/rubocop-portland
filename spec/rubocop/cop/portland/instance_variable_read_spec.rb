# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::InstanceVariableRead, :config do
  it 'reports an instance variable read, naming the bare field' do
    expect_offense(<<~'RUBY')
      def label = "#{@name}"
                     ^^^^^ Portland reads a field by its bare name — write `name`.
    RUBY
  end

  it 'leaves a bare name alone' do
    expect_no_offenses(<<~'RUBY')
      def label = "#{name}"
    RUBY
  end
end
