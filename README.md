# rubocop-portland

The migration linter for [Portland](https://github.com/portlandlang/portland), a Ruby-flavored language for Apple silicon. Portland's promise to Rubyists is that it feels like home and porting is mechanical. Each cop here finds one Ruby spelling Portland changes or removes, says what Portland says instead, links the ledger page that explains why, and rewrites it where the rewrite is mechanical.

Run it on a gem or an app to see how far the code is from Portland today, and which of those distances are decided and which are still open questions.

## Installation

Not yet on RubyGems.org. From git, in a Gemfile:

```ruby
gem "rubocop-portland", github: "portlandlang/rubocop-portland", require: false
```

## Usage

Add the plugin to `.rubocop.yml`:

```yaml
plugins:
  - rubocop-portland
```

Then see only the Portland cops:

```bash
bundle exec rubocop --only Portland
```

And apply the mechanical rewrites:

```bash
bundle exec rubocop --only Portland -A
```

## The cops

Each cop carries a `Difference` and a `Status` in `config/default.yml`, Portland's principle 2 kinds: **thesis**, a difference Portland exists for (values never mutate, failures are values, the runtime is closed); **taste**, a spelling Portland removed, which may come back; and **gap**, something Portland hasn't decided or built yet. [ruby_research](https://github.com/portlandlang/ruby_research)'s readiness census reads the same keys to grade every gem on RubyGems.org, shown at [portlandlang.com/gems](https://portlandlang.com/gems/).

| Cop | Finds | Difference | Status | Rewrites |
|---|---|---|---|---|
| `Portland/ForLoop` | `for x in list` | taste | decided | yes, to `list.each do \|x\|` (unsafe) |
| `Portland/NumberedParameter` | `_1`, `_2` | taste | decided | a lone `_1` to `it` |
| `Portland/GlobalVariable` | `$count`, `$1`, `$~` | taste | decided | |
| `Portland/BeginEndBlock` | `BEGIN { }`, `END { }` | taste | decided | |
| `Portland/FlipFlop` | flip-flops | taste | decided | |
| `Portland/Fetch` | `fetch` | taste | decided | |
| `Portland/Inheritance` | `class A < B`, `super` | taste | decided | |
| `Portland/SingletonClass` | `class << self` | taste | decided | |
| `Portland/InstanceVariableRead` | reading `@name` | taste | decided | |
| `Portland/ClassVariable` | `@@total` | thesis | decided | |
| `Portland/RaiseRescue` | `raise`, `rescue`, `ensure`, `retry` | thesis | decided | |
| `Portland/InPlaceMutator` | `push`, `upcase!`, and kin | thesis | decided | |
| `Portland/FreezeFamily` | `freeze`, `dup`, `clone` | thesis | decided | |
| `Portland/MethodMissing` | `method_missing` | thesis | decided | |
| `Portland/RuntimeDefineMethod` | `define_method`, `const_get` | thesis | decided | |
| `Portland/EvalFamily` | `eval`, `send`, `instance_eval` | thesis | decided | |
| `Portland/ThreadModel` | `Thread`, `Mutex`, `Queue` | thesis | decided | |
| `Portland/ShiftAppend` | `<<` (off by default) | thesis | decided | |
| `Portland/InstanceVariableWrite` | assigning `@name` | thesis | undecided | |
| `Portland/AttrWriter` | `attr_writer`, `attr_accessor` | thesis | undecided | |
| `Portland/AttrReader` | `attr_reader` | taste | undecided | |
| `Portland/Bitwise` | `&`, `\|`, `^`, `~`, `>>` | taste | undecided | |
| `Portland/Visibility` | `private`, `protected` | gap | undecided | |
| `Portland/RequireByName` | `require "name"` | gap | undecided | |
| `Portland/Regex` | regex literals | gap | undecided | |
| `Portland/Splat` | `*args`, `**options` | gap | undecided | |

## Development

`script/bootstrap` installs dependencies, and `script/test` runs the specs and RuboCop. New cops start from `bundle exec rake 'new_cop[Portland/Name]'`.

## License

MIT.
