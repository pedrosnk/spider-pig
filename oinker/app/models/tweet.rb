class Tweet < ActiveRecord::Base
  belongs_to :tweeter
  validates_presence_of :twitter_id, :tweeter_id
  validates_uniqueness_of :twitter_id
end
