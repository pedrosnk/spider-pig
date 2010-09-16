class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field   :screen_name,   :type   => String
  field   :information,  :type   => String

  index :screen_name, :unique => true, :background => true

  embeds_one :klout
  embeds_one :twittercounter

end
