#
# A library for building Cinch bots
#  that live on heroku and use redis
#

redis = options['no-redis']

file "Procfile", "Procfile"

file "Gemfile", "Gemfile.erb", locals: { redis?: redis }

if redis
  # This has the connection configs for redis.
  # You'll need to fill it out.

  file "config/redis.yml", "redis.yml"
end

file "config/bot.yml", "bot.yml.erb"

# This script will start the bot up.  Foreman uses it
#  to run the bot.  Alternately, you can call it directly
#  to run it locally.

file "bot.rb", "bot.rb.erb", locals: { redis?: redis }, chmod: '+x'

file "lib/#{project}.rb",          "root.rb.erb"

# These are some helper files that the bot
#  uses to set up its connections:

file "lib/helpers/configure.rb",   "configure.rb"
file "lib/helpers/constantize.rb", "constantize.rb"

# This is the module that handles the Cinch bot:

file "lib/env/bot.rb",             "env_bot.rb"

if redis
  # This module handles the redis connection:

  file "lib/env/redis.rb",         "env_redis.rb"
end

# This is where you can define your first plugin:

file "lib/#{project}/plugin.rb",   "plugin.rb.erb"
