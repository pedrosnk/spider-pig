class TweetStatus
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :tweeted_by
  field :status
  field :re_tweet_from
  field :reply_from

  index :tweeted_by, :background => true, :unique => false



end
