# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"
set :environment, ENV['RAILS_ENV']

every :hour do
  runner "WordpressTemplate.update"
end
