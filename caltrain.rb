###
# Ping twitter for latest tweets on Caltrain
# 
# Returns
# - If latest tweet mentioning delays is less than an hour old, that tweet
# - Otherwise, nil
# 
# @author vanevery@gmail.com
# @website http://asheepapart.blogspot.com
####

tweets = Tweets.about "caltrain", { :within => 1.5 }

puts tweets.pop if tweets.size > 0
puts "#{tweets.size - 1} more tweets" if tweets.size > 1

##
# Interface to Tweets on twitter
##
class Tweets
  def self.about(user, opts)
  end
end
