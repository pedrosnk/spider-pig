class Tweeters
  include Mongoid::Document

  field   :time_zone
  field   :description
  field   :friends_count
  field   :profile_sidebar_fill_color
  field   :url
  field   :show_all_inline_media
  field   :follow_request_sent
  field   :lang
  field   :verified
  field   :profile_use_background_image
  field   :favourites_count
  field   :created_at
  field   :profile_sidebar_border_color
  field   :location
  field   :profile_background_image_url
  field   :profile_image_url
  field   :listed_count
  field   :following
  field   :profile_background_color
  field   :statuses_count
  field   :profile_background_tile
  field   :protected
  field   :screen_name
  field   :profile_text_color
  field   :followers_count
  field   :name
  field   :contributors_enabled
  field   :geo_enabled
  field   :notifications
  field   :utc_offset
  field   :profile_link_color


  embeds_one :klout
  embeds_one :twittercounter

end
