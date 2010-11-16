class StatusInfluence
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #decrapeted
  field :text
  
  field :tweet_id
  field :user    
  field :tweeted_by
  field :status
  field :re_tweet_from
  field :reply_from
  field :retweet_count
  field :influence_number

  index :tweeted_by, :background => true, :unique => false
  
end
