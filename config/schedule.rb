# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/whenever.log"

every 1.day do # 1.minute 1.day 1.week 1.month 1.year is also supported
  rake "crawler"
end


# Learn more: http://github.com/javan/whenever
