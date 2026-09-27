# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Visibility, :config do
  it 'reports private and private def' do
    expect_offense(<<~RUBY)
      class Box
        private
        ^^^^^^^ Portland has no `private` yet — visibility is undecided (portland#133).
        def secret = 1
        protected def peek = 2
        ^^^^^^^^^ Portland has no `protected` yet — visibility is undecided (portland#133).
      end
    RUBY
  end

  it 'leaves a method named public on a receiver alone' do
    expect_no_offenses(<<~RUBY)
      listing.public
    RUBY
  end
end
