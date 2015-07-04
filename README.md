# Blog Subscribers Number

Post my blog subscriber number to GrowthForecast

* [feedly](https://feedly.com/)
* [Hatena::Bookmark](http://b.hatena.ne.jp/)
* [Live Dwango Reader](http://reader.livedoor.com/)

## for development

### Require

* [GrowthForecast](http://kazeburo.github.io/GrowthForecast/)

### Setup

    $ bundle install --path vendor/bundle --binstubs vendor/bundle/bin
    $ cp settings.example.yml settings.yml

Modify settings.yml

### Clockworkd

Create an awesome GitHub feed

    # Start
    $ bundle exec clockworkd -c clock.rb start --log

    # Stop
    $ kill `cat tmp/clockworkd.clock.pid`