# Pings

This task is a challenge for back end engineers and developers.

Every Tanda customer gets a time clock - a piece of hardware of that staff use to clock in and out of work. The time clock is designed to work without an internet connection for extended periods, as long as it can sometimes come online and sync up with the main Tanda system. While online, the time clock attempts to ping Tanda regularly, and we can use a record of these pings to paint a picture of the device's reliability (as well as other interesting things, like 3G reliability in different parts of the country).

Your challenge is to build a small server that acts as an API for time clock pings. You should be able to make a POST to the server to record a time clock communicating to Tanda, and you should be able to GET data about past pings for specific time clocks.

This is a feature that already exists in Tanda. We have provided most of the existing server's API - your task is to write the underlying code.

## Setting up

For this challenge, you'll need to install the [Ruby](https://www.ruby-lang.org/en/) programming language. But you won't need to write any Ruby (unless you want to) - you can do this challenge in any language you like.

We've provided a test file, `pings.rb`, which runs tests against your server. It should run smoothly if you have [Ruby](https://www.ruby-lang.org/en/) installed. You won't need to write any Ruby for this task, unless you want to also write your server in Ruby. If you do, please write it in a separate file, *not* in `pings.rb`. The only change you should make to `pings.rb` is to edit the first line with your server's local address.

Run the test file by running `ruby pings.rb`.

## The challenge

Your challenge is to write a server that passes all the tests in `pings.rb`, based on this API spec:

**Storing data**

The server should accept POST requests that contain a `device_id` and an `epoch_time`. The two should be stored together - each device ID can have many epoch times (each representing a ping).

For example, for device ID `eab88fbc-10c6-11e2-b622-1231381359d0`, to record a ping at `2016-02-24 12:52:44 +1000` you'd make a POST to `/eab88fbc-10c6-11e2-b622-1231381359d0/1456282364`.

You can use any method you like for storing the underlying data, and we'll be interested to hear your thoughts on what you chose. Data persistence is important so in-memory-only solutions are not recommended.

**Retrieving data for a specific device**

The server should accept GET requests to query ping times for specific device IDs, or for `all` device IDs. This should work in two formats: `/deviceID/:date` or `/deviceID/:from/:to`.

`:date` must be an ISO formatted date (`YYYY-MM-DD`). This represents all pings for that date in the UTC time zone. For example the request `/:deviceId/2016-02-24` would get all pings for the device between `2016-02-24 00:00:00 UTC` (**inclusive**) and `2016-02-25 00:00:00 UTC` (**exclusive**).

`:from`, and `:to` should accept either dates  or unix timestamps. If they are ISO dates, the logic above applies. In general, `:to` should be exclusive, but `:from` should be inclusive. Thus, all of the following requests should return the same data:

* `/:deviceId/2016-02-21/2016-02-24`
* `/:deviceId/1456012800/2016-02-24`
* `/:deviceId/2016-02-21/1456272000`
* `/:deviceId/1456012800/1456272000`

All of these requests would return a list of unix timestamps, one for each ping. For example:

```javascript
[
  1459209638,
  1459209941,
  1459210248,
  1459210552,
  1459210856,
  1459211159,
  1459211463,
  1459211768,
  1459212071
]
```

**Retrieving data for all devices**

Finally, replacing the `device_id` parameter with the string `all` should return data for all device IDs, formatted as a hash. This should work for all the different requests mentioned above, including `/all/:date`, and `/all/:from/:to`.

```javascript
{
  'eab88fbc-10c6-11e2-b622-1231381359d0': [
    1456050274,
    1456083687,
    1456129212,
    1456169429
  ],
  '5225a416-3394-4e9f-9d97-e371d7615197': [
    1456190884,
    1456230519
  ]
}
```

**Retrieving a list of devices**

GET `/devices` should return a list of device IDs:

```javascript
[
  'eab88fbc-10c6-11e2-b622-1231381359d0',
  '5225a416-3394-4e9f-9d97-e371d7615197'
]
```

**Deleting data**

If a POST is made to `/clear_data`, the server should delete all stored data.

## Submitting your code

Before submitting, please ensure all tests in `pings.rb` pass. Package your code and instructions on how to run it alongside the files we've given you (this file, the test file, etc) in a zip archive and email that to us. If you were emailed this task, just reply to whoever emailed it to you. Otherwise send it to developers@tanda.co

# Sinatra Application Template

A base Sinatra application template. Just fork and build. Yay!
Includes Bundler, DataMapper, and RSpec, all ready to go.

## Configuration

Dependencies and all configuration is done in <tt>environment.rb</tt>. Your
database is also set up here. DataMapper will use sqlite3 by default. Tests
use the sqlite3-memory adapter (no configuration needed).

Add your controller actions in <tt>application.rb</tt>. Views for these actions
are placed in the <tt>views</tt> directory. Static files, including a stock
stylesheet, go in the <tt>public</tt> directory. Models go in the <tt>lib</tt>
directory and are auto-loaded.

Environment variables that you want to expose to your application can be added
in <tt>.env</tt>

## Testing

Add your specs in <tt>spec</tt>; just require <tt>spec_helper.rb</tt> to
pre-configure the test environment. A number of samples are provided (including
a sample model, which can be removed). To run the specs:

    bundle exec rake spec

## Getting Started

    bundle install
    bundle exec foreman start

## Extras

We've included a handy <tt>console</tt> script that fires up irb with your
environment loaded. To load it, use the Rake task:

    bundle exec rake console

## Thanks

This project includes contributions from [several awesome developers](https://github.com/zapnap/sinatra-template/graphs/contributors).

(c) 2015 Nick Plante. This code is distributed under the MIT license.
