# frozen_string_literal: true

require_relative 'lib/rubocop/portland/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop-portland'
  spec.version = RuboCop::Portland::VERSION
  spec.authors = ['Shane Becker']
  spec.email = ['veganstraightedge@gmail.com']

  spec.summary = "The migration linter for Portland: a cop for each Ruby difference the language's ledger names."
  spec.description = 'Portland is a Ruby-flavored language whose promise to Rubyists is that porting is mechanical. ' \
                     'Each cop here finds one Ruby spelling Portland changes or removes, links the ledger page that ' \
                     'says why, and rewrites it where the rewrite is mechanical.'
  spec.homepage = 'https://github.com/portlandlang/rubocop-portland'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 4.0.7'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/portlandlang/rubocop-portland'
  spec.metadata['changelog_uri'] = 'https://github.com/portlandlang/rubocop-portland/blob/main/CHANGELOG.md'

  # MFA for gem pushes, so no one can publish a new version without it.
  # See: https://guides.rubygems.org/mfa-requirement-opt-in/
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['default_lint_roller_plugin'] = 'RuboCop::Portland::Plugin'

  spec.add_dependency 'lint_roller', '~> 1.1'
  spec.add_dependency 'rubocop', '>= 1.91'
end
