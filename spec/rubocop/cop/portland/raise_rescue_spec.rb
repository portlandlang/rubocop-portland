# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::RaiseRescue, :config do
  it 'reports raise and fail' do
    expect_offense(<<~RUBY)
      raise ArgumentError, "empty" if text.empty?
      ^^^^^ Portland has no exceptions — return a `failure("why")` instead.
      fail "no"
      ^^^^ Portland has no exceptions — return a `failure("why")` instead.
    RUBY
  end

  it 'reports rescue and ensure' do
    expect_offense(<<~RUBY)
      begin
        work
      rescue StandardError
      ^^^^^^ Portland has no exceptions to rescue — handle the returned failure with `or`, `case/in`, or `failure?`.
        retry
        ^^^^^ Portland has no exceptions to rescue — handle the returned failure with `or`, `case/in`, or `failure?`.
      ensure
      ^^^^^^ Portland has no exceptions to rescue — handle the returned failure with `or`, `case/in`, or `failure?`.
        done
      end
    RUBY
  end

  it 'leaves a method named raise on a receiver alone' do
    expect_no_offenses(<<~RUBY)
      alarm.raise
    RUBY
  end
end
