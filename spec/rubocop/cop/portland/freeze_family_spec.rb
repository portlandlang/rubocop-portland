# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::FreezeFamily, :config do
  it 'reports freeze, frozen?, dup, and clone' do
    expect_offense(<<~RUBY)
      LABELS = %w[low high].freeze
                            ^^^^^^ Portland values never mutate, so `freeze` has nothing to do — drop the call.
      copy = original.dup
                      ^^^ Portland values never mutate, so `dup` has nothing to do — drop the call.
    RUBY
  end

  it 'leaves a plain binding alone' do
    expect_no_offenses(<<~RUBY)
      copy = original
    RUBY
  end
end
