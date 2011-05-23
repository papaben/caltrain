###
# Ping twitter for latest tweets on Caltrain
# 
# Returns
# - Latest tweet mentioning caltrain within last 1.5 hours
# - Or nothing if no tweets
# 
# @author  vanevery@gmail.com
# @website http://asheepapart.blogspot.com
####
require 'net/http'
require 'json'
require 'date'
require 'time'

##
# Interface to Tweets on twitter
##
class Tweets
  SEARCH_API_URL = 'http://search.twitter.com/search.json?'

  # Search for tweets about user
  # opts is a hash of search restrictions
  #  :within - restrict to tweets within last x seconds
  def self.about(user, opts)
    opts ||= {}

    # Get the latest from twitter on user
    raw_tweets = Net::HTTP::get URI.parse("#{SEARCH_API_URL}q=%40#{user}")

    begin
      parsed_tweets = JSON.parse(raw_tweets)["results"]
    rescue JSON::ParserError => parse_error
      raise "Bad response from twitter"
    end

    if (opts[:within])
      now = DateTime.now.to_time

      parsed_tweets = parsed_tweets.select do |tweet|
        tweeted_time = DateTime.parse(tweet["created_at"]).to_time

        now - tweeted_time < opts[:within]
      end
    end

    # We only care about the text
    parsed_tweets.map { |tweet| tweet["text"] }
  end
end

##
# Begin Script
##
begin
  tweets = Tweets.about "caltrain", { :within => 5400 }
rescue => e
  # Hmm, looks like we'll need to go to the website manually
  puts "I could not get data from Twitter"
  puts e
  exit
end

puts tweets.shift if tweets.size > 0
puts "#{tweets.size} more tweets" if tweets.size > 0

