# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Portland::EvalFamily, :config do
  it 'reports send, eval, and the instance_ family' do
    expect_offense(<<~RUBY)
      receiver.send(name, value)
               ^^^^ Portland has no `send` — the runtime is closed; call the method you mean by name.
      eval(source)
      ^^^^ Portland has no `eval` — the runtime is closed; call the method you mean by name.
      config.instance_eval(&block)
             ^^^^^^^^^^^^^ Portland has no `instance_eval` — the runtime is closed; call the method you mean by name.
      token.instance_variable_get(:@text)
            ^^^^^^^^^^^^^^^^^^^^^ Portland has no `instance_variable_get` — the runtime is closed; call the method you mean by name.
    RUBY
  end

  it 'leaves a direct call alone' do
    expect_no_offenses(<<~RUBY)
      receiver.update(value)
    RUBY
  end
end
