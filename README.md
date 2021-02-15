# CGTrader Level System

Keep track of user levels, manage levels themselves and bonuses that go along with reaching new levels.

## Prerequisites

Before you begin, ensure you have installed the following on your machine:
* `ruby` version `~> 3.0`

## Setup

1. `gem install` - Install required gems.
2. `irb -Ilib -rcgtrader_levels` - Launch IRB REPL with classes already loaded.
3. For sample database for testing run the database setup located in `spec/support/init_database.rb`.

## Example usage

```ruby
CgtraderLevels::Level.create!(experience: 0, title: 'First level')
CgtraderLevels::Level.create!(experience: 10, title: 'Second level')

CgtraderLevels::User.create!(coins: 1, tax: 20)
CgtraderLevels::User.update!(reputation: 10) # Assigns second level and grants bonuses to user
```

## Running specs

`rspec ./spec` - Run all specs in spec folder.
