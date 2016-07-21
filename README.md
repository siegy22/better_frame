# BetterFrame

Everyone hates iframes. This is why this rails plugin exists.

You'll get a much smoother usage of your app when embedded.
Basically what this plugin does is the following:

* Inject your html code onto the foreign website.
* Handle all events (link clicking, form submitting) with javascript.
* Write the browser history to make the navigation as normal as possible.
* Write rails path + parameter onto the foreign site.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'better_frame'
```

And then execute:

    $ bundle

## Usage

### Internal (in your rails app)

**NOTE: you need to make all your forms `remote: true` as this should not
  redirect to the rails app if you're submitting a form.

To start, you need to mount the engine in your rails routes:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount BetterFrame::Engine => "/better_frame"

  ...
end
```

As this only works with setting the `Access-Control-Allow-Origin` header, you'll
need to include a concern to your controllers to make it available for
better_frame to load. (You also may include it in your ApplicationController if
you want.)

```ruby
# app/controllers/examples_controller.rb
class ExamplesController < ApplicationController
  include BetterFrameable
end
```

You'll have to set the `Access-Control-Allow-Origin` using the
`BETTER_FRAME_ORIGIN` environment variable.

     $ export BETTER_FRAME_ORIGIN=http://example.com

Or using [dotenv](https://github.com/bkeepers/dotenv)

```
BETTER_FRAME_ORIGIN=http://example.com
```

Side note: If you have `protect_from_forgery with: ...` in your controller you
have to delete that because of the cross site origin requests.

#### Javascript:

If you need something like `$(document).ready`, better_frame fires an event with
`better_frame:load`.
This event is fired everytime the side is loaded with better_frame.

Usage:

```javascript
$("#app-content").on("better_frame:load", function(){
    alert("site was loaded with better_frame!");
});
```

### External (on your website which should embed the rails app)

**NOTE: you need to have jQuery on the website which is embedding your rails
  app**

On your website do the following:

```html
<div id="app-content" data-baseurl="http://example.com/my_site" data-railsurl="http://my-rails-app.com"></div>
<script src="http://my-rails-app.com/better_frame" type="text/javascript"></script>
```

In `<script src="..."` needs the better_frame route to be placed. As defined in
the routes in your rails application. (See internal usage)

#### IMPORTANT!!

Since this plugin is writing the history of your browser, as long as you stay on the site this
will work perfectly (when using history back and forward), but if you reload the
site, you have to make sure that your foreign site stays on the baseurl no
matter what's after the baseurl.

E.g.
Visiting http://example.com/my_site loads up your javascript and the root of the
rails app. Then you click a link of your rails app let's say products, which
will link to `/products` on your rails app. This will work properly and you'll
see that the URL has changed to: http://example.com/my_site/products
Now if you reload your website has to render the http://example.com/my_site
(baseurl) but without changing the URL. If you set up your website like that you
can pass in arguments and paths.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/better_frame. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
