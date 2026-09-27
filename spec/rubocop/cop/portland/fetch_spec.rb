# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::Fetch, :config do
  it 'reports fetch on a receiver' do
    expect_offense(<<~RUBY)
      port = settings.fetch(:port, 3000)
                      ^^^^^ Portland retires `fetch` — write `collection[key] or default`, or handle the missing key.
    RUBY
  end

  it 'leaves an index alone' do
    expect_no_offenses(<<~RUBY)
      port = settings[:port]
    RUBY
  end
end
