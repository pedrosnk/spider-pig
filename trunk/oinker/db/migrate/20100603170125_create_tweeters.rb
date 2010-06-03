class CreateTweeters < ActiveRecord::Migration
  def self.up
    create_table :tweeters do |t|
      t.datetime :created_at
      t.integer :friends_count
      t.string :profile_image_url
      t.integer :followers_count
      t.string :screen_name
      t.string :location
      t.boolean :geo_enabled
      t.string :time_zone
      t.boolean :protected
      t.string :description
      t.string :profile_background_image_url
      t.string :url
      t.integer :statuses_count

      t.timestamps
    end
  end

  def self.down
    drop_table :tweeters
  end
end
