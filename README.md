# Castache

Simple structured cache for ruby apps. Marshals objects to and from Redis
quickly and painlessly. 

## Installation

Add this line to your application's Gemfile:

    gem 'castache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install castache

## Usage
    
    require 'castache'
    Castache.redis = Redis.new # you can also pass it a redis:// URI string or hash of options for Redis.new
    @object = Castache.fetch 'cache:key' do
      # some expensive operation goes here...
      {hello: 'world'}
    end
    p @object

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
