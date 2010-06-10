class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.datetime :created_at
      t.integer :tweeter_id
      t.integer :twitter_id
      t.string :text
      t.string :source
      t.integer :in_reply_to_status_id
      t.string :in_reply_to_screen_name

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
