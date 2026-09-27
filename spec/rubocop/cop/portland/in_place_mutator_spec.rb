# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::InPlaceMutator, :config do
  it 'reports the mutators by name' do
    expect_offense(<<~RUBY)
      words.push(word)
            ^^^^ Portland values never mutate — `push` has no Portland meaning; rebind the name to a new value.
      title.upcase!
            ^^^^^^^ Portland values never mutate — `upcase!` has no Portland meaning; rebind the name to a new value.
    RUBY
  end

  it 'leaves the non-mutating spellings alone' do
    expect_no_offenses(<<~RUBY)
      title = title.upcase
      words = words + [word]
    RUBY
  end
end
