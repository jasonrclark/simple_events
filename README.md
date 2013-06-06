# SimpleEvents

A basic eventing system

## Installation

Add this line to your application's Gemfile:

    gem 'simple_events'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_events

## Usage

Create a new event dispatcher:

    events = SimpleEvent.new
    
Subscribe to an event:

    events.subscribe(:all_done) do |*args|
      # Handle the event here...
    end

Notify of an event:

    events.notify(:all_done, "pass", "along", "args")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
