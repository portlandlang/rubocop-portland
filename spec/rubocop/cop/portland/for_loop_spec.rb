# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::ForLoop, :config do
  it 'rewrites a for loop to each' do
    expect_offense(<<~RUBY)
      for word in words
      ^^^^^^^^^^^^^^^^^ Portland has no `for` — iterate with `each`.
        puts word
      end
    RUBY

    expect_correction(<<~RUBY)
      words.each do |word|
        puts word
      end
    RUBY
  end

  it 'takes the optional do along with the head' do
    expect_offense(<<~RUBY)
      for word in words do
      ^^^^^^^^^^^^^^^^^^^^ Portland has no `for` — iterate with `each`.
        puts word
      end
    RUBY

    expect_correction(<<~RUBY)
      words.each do |word|
        puts word
      end
    RUBY
  end

  it 'keeps several loop variables as block parameters' do
    expect_offense(<<~RUBY)
      for key, value in pairs
      ^^^^^^^^^^^^^^^^^^^^^^^ Portland has no `for` — iterate with `each`.
        puts key
      end
    RUBY

    expect_correction(<<~RUBY)
      pairs.each do |key, value|
        puts key
      end
    RUBY
  end

  it 'parenthesizes a range or an operator expression before calling each on it' do
    expect_offense(<<~RUBY)
      for number in 1..3
      ^^^^^^^^^^^^^^^^^^ Portland has no `for` — iterate with `each`.
        puts number
      end
    RUBY

    expect_correction(<<~RUBY)
      (1..3).each do |number|
        puts number
      end
    RUBY
  end

  it 'leaves each alone' do
    expect_no_offenses(<<~RUBY)
      words.each do |word|
        puts word
      end
    RUBY
  end
end
