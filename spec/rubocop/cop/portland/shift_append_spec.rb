# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::ShiftAppend, :config do
  let(:cop_config) { { 'Enabled' => true } }

  it 'reports <<, noting the mutable binding it needs' do
    expect_offense(<<~RUBY)
      words << word
            ^^ In Portland, `<<` rebinds the name — declare it `mutable`; other holders keep the old value.
    RUBY
  end

  it 'leaves + alone' do
    expect_no_offenses(<<~RUBY)
      words = words + [word]
    RUBY
  end
end
