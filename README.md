# woodhouse-external

Glue code to allow dispatching jobs to another application's Woodhouse nodes.

## Usage

Add

      gem 'woodhouse-external', github: 'mboeh/woodhouse-external'

to your Gemfile.

Tell Woodhouse to load the `external` extension:

      Woodhouse.configure do |woodhouse|
        # ...
        woodhouse.extension :external
      end

Set up an external gateway by providing alternate AMQP parameters. These are merged with the ones which you already have set.

      OtherWoodhouse = Woodhouse::External.connect(vhost: "/other-app")

You can now dispatch jobs to workers on the other vhost just like you would to a worker in your own app.

      OtherWoodhouse::SomeWorker.async_do_a_thing(:why => "because")

This uses `const_missing`/`method_missing` and doesn't validate that the workers actually exist, so test thoroughly
and check your spelling!
