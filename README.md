# rescue-with

Inline rescue a specific exception type in Ruby.

## Background

The modifier form of `rescue` in Ruby
[can](https://github.com/bbatsov/ruby-style-guide#no-rescue-modifiers)
[be](https://rubocop.readthedocs.io/en/latest/cops_style/#stylerescuemodifier)
[dangerous](https://www.rubytapas.com/2012/11/12/episode-022-inline-rescue/)
because it rescues from `StandardError` and can't be targeted toward a more
specific exception. To rescue from a specific exception the full `begin ...
rescue ... end` syntax must be used which can be needlessly verbose as evident
from this [proposal](https://bugs.ruby-lang.org/issues/6739) from 2013.

## Installation

```
gem install rescue-with
```

## Usage

This gem adds the syntax:

```ruby
... rescue ExceptionType.with { ... }
```

To rescue from `ExceptionType` and return the result `{ ... }`. If you need the
exception itself and don't want to use `$!` then do:

```ruby
... rescue ExceptionType.with { |e| ... }
```

## Example

Output an error message to `stderr` if a file can't be read:

```ruby
data = File.read('none') rescue Errno::ENOENT.with { $stderr.puts('No data') }
```

## Caveat

Because the modifier form of `rescue` only rescues from `StandardError` this
syntax only works if `StandardError` is an ancestor of `ExceptionType`. This
shouldn't be a problem most of the time as `Exception`s that aren't a subclass
of `StandardError` are rarely rescued.

## License

The gem is available as open source under the terms of [The
Unlicense](http://unlicense.org/).
