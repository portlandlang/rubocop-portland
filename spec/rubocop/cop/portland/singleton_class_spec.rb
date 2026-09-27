# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::SingletonClass, :config do
  it 'reports class << self' do
    expect_offense(<<~RUBY)
      class Token
        class << self
        ^^^^^^^^^^^^^ Portland has no `class << self` — write each method as `def self.name` in the type's body.
          def build = new
        end
      end
    RUBY
  end

  it 'leaves def self. alone' do
    expect_no_offenses(<<~RUBY)
      class Token
        def self.build = new
      end
    RUBY
  end
end
