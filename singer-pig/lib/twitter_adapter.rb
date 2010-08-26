# Author: Renato Fernandes de Queiroz
 
class Twitter

  include Cassandra::Constants
  

  def initialize
    @store = Cassandra.new('spider-pig')
    @client  = Grackle::Client.new
  end

  def store_user screen_name
    tweeter = Tweeter.new
    tweeter.load(screen_name)
    tweeter.save!
  end


  def store_timeline screen_name
    timeline = @client.statuses.user_timeline.json?(:screen_name => screen_name)

    timeline.each do |tweet|
      unless @store.exists?(:Statuses, tweet.id)
        hash = Tweeter.tweet2hash(tweet)
        @store.insert(:Statuses, tweet.id, hash)
      end

    end
  end

  def store_friends screen_name
    friends = @client.friends.ids.json?(:screen_name => screen_name)
    friends.each do |id|
      friend = Tweeter.new
      friend.load_by_id id
      friend.save
    end


  end

  def store_followers

  end


  private

  def self.tweet2hash tweet
    hash = {}
    hash[:created_at] = tweet.created_at unless tweet.created_at.nil?
    hash[:id] = tweet.id unless tweet.id
    hash[:text] = tweet.text unless tweet.text
    hash[:source] = tweet.source unless tweet.source
    hash[:in_reply_to_status_id] = tweet.in_reply_to_status_id unless tweet.in_reply_to_status_id
    hash[:in_reply_to_screen_name] = tweet.in_reply_to_screen_name unless tweet.in_reply_to_screen_name
    hash
  end


  def self.user2hash user
    hash = {}
    hash[:notifications]=user.notifications unless user.notifications.nil?
    hash[:profile_background_image_url]=user.profile_background_image_url unless user.profile_background_image_url.nil?
    hash[:profile_image_url]=user.profile_image_url unless user.profile_image_url.nil?
    hash[:description]=user.description unless user.description.nil?
    hash[:lang]=user.lang unless user.lang.nil?
    hash[:statuses_count]=user.statuses_count unless user.statuses_count.nil?
    hash[:profile_sidebar_fill_color]=user.profile_sidebar_fill_color unless user.profile_sidebar_fill_color.nil?
    hash[:profile_background_tile]=user.profile_background_tile unless user.profile_background_tile.nil?
    hash[:screen_name]=user.screen_name unless user.screen_name.nil?
    hash[:contributors_enabled]=user.contributors_enabled unless user.contributors_enabled.nil?
    hash[:profile_sidebar_border_color]=user.profile_sidebar_border_color unless user.profile_sidebar_border_color.nil?
    hash[:following]=user.following unless user.following.nil?
    hash[:geo_enabled]=user.geo_enabled unless user.geo_enabled.nil?
    hash[:created_at]=user.created_at unless user.created_at.nil?
    hash[:followers_count]=user.followers_count unless user.followers_count.nil?
    hash[:friends_count]=user.friends_count unless user.friends_count.nil?
    hash[:verified]=user.verified unless user.verified.nil?
    hash[:profile_background_color]=user.profile_background_color unless user.profile_background_color.nil?
    hash[:favourites_count]=user.favourites_count unless user.favourites_count.nil?
    hash[:protected]=user.protected unless user.protected.nil?
    hash[:url]=user.url unless user.url.nil?
    hash[:profile_text_color]=user.profile_text_color unless user.profile_text_color.nil?
    hash[:name]=user.name unless user.name.nil?
    hash[:time_zone]=user.time_zone unless user.time_zone.nil?
    hash[:location]=user.location unless user.location.nil?
    hash[:utc_offset]=user.utc_offset unless user.utc_offset.nil?
    hash[:profile_link_color]=user.profile_link_color unless user.profile_link_color.nil?
    hash
  end

end
