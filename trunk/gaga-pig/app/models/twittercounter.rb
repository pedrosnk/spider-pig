class Twittercounter
  include Mongoid::Document

  field :followers
  field :followers_yesterday
  field :followers_average

  field :following
  field :following_yesterday
  field :following_average

  field :tweets
  field :tweets_yesterday
  field :tweets_average

  embedded_in :tweeters, :inverse_of => :twittercounter

end
