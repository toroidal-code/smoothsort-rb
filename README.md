# Smoothsort
[![Gem Version](https://badge.fury.io/rb/smoothsort.png)](http://badge.fury.io/rb/smoothsort)
[![Dependency Status](https://gemnasium.com/toroidal-code/smoothsort-rb.png)](https://gemnasium.com/toroidal-code/smoothsort-rb)


This is an implementation of Djikstra's smoothsort algorithm, as both a C extension, and native ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'smoothsort'

Or for the native ruby version:

    gem 'smoothsort', github: 'toroidal-code/smoothsort-rb', branch: 'pure-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smoothsort

## Usage

```ruby
>> require 'smoothsort' #=> true
>> a = (1..20).to_a.shuffle
=> [13, 19, 2, 11, 9, 18, 14, 10, 3, 7, 1, 6, 8, 4, 16, 5, 12, 17, 15, 20]
>> a.ssort
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
>> a
=> [13, 19, 2, 11, 9, 18, 14, 10, 3, 7, 1, 6, 8, 4, 16, 5, 12, 17, 15, 20]
>> a.ssort!
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
>> a
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
