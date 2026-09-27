# frozen_string_literal: true

require 'rubocop-portland'
require 'rubocop/rspec/support'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.raise_on_warning = true
  config.fail_if_no_examples = true

  config.order = :random

  # Every example parses as Ruby 4.0, the Ruby the migrating code is on.
  config.include_context 'ruby 4.0'
  Kernel.srand config.seed
end
