# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::RequireByName, :config do
  it 'reports require by name' do
    expect_offense(<<~RUBY)
      require "json"
      ^^^^^^^ Portland has no `require` by name yet (portland#116) — `require_relative` resolves today.
    RUBY
  end

  it 'leaves require_relative alone' do
    expect_no_offenses(<<~RUBY)
      require_relative "my_gem/version"
    RUBY
  end
end
