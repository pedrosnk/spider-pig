class TweetFollowing
  include Mongoid::Document

  field :screen_name,           :type => String
  field :following_screen_name, :type => String
  

end
