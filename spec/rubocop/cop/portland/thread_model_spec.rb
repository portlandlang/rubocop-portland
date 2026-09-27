# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::ThreadModel, :config do
  it 'reports Thread, Mutex, Queue, Fiber, and Ractor' do
    expect_offense(<<~RUBY)
      worker = Thread.new { work }
               ^^^^^^ Portland has no `Thread` — concurrency is `together` and its task lines.
      lock = Mutex.new
             ^^^^^ Portland has no `Mutex` — concurrency is `together` and its task lines.
    RUBY
  end

  it 'leaves a namespaced constant of the same name alone' do
    expect_no_offenses(<<~RUBY)
      job = Jobs::Queue.new
    RUBY
  end
end
