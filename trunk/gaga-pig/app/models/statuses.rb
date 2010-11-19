class Statuses
  include Mongoid::Document

  field :in_reply_to_screen_name
  field :retweeted
  field :truncated
  field :created_at
  field :in_reply_to_user_id
  field :source
  field :contributors
  field :in_reply_to_status_id
  field :retweet_count
  field :place
  field :coordinates
  field :user
  field :user_name
  field :favorited
  field :geo
  field :text
  field :id_str

end
