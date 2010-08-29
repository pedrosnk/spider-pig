require './twitter_model'


class Tweeter < TwitterModel

  def load(search_key)
    if search_key[:id]
      load_by_id(search_key[:id])
      load_from_twitter(:id => search_key[:id]) if @hash.empty?
    elsif search_key[:screen_name]
      load_by_screen_name(search_key[:screen_name])
      load_from_twitter(:screen_name => search_key[:screen_name]) if @hash.empty?
    end
  end
 

  def load! (search_key)
    if search_key[:id]
      load_from_twitter(:id => search_key[:id])
    elsif search_key[:screen_name]
      load_from_twitter(:screen_name => search_key[:screen_name])
    end
    save!
  end


  def save!
    if @hash
      @store.insert(:Users, @hash['id'], @hash)
      @store.insert(:Usernames, @hash['screen_name'], 'id' => @hash['id'])
      return true
    end
    return false
  end

  
  def add_friend(search_key)
    friend = Tweeter.new
    friend.load!(search_key)
    #@store.insert()
  end
  

  def friend?
    #@store.get()
  end

  private

  def load_by_id(id)
    @hash = @store.get(:Users, id)
  end

  def load_by_screen_name(screen_name)
    @hash = {}
    vec = @store.get(:Usernames, screen_name)
    if ! vec.empty?
      load_by_id(vec['id'])
    end
  end

  def load_from_twitter(search_key)
    user = @client.users.show.json?(search_key)
    @hash = Tweeter.twitter2hash(user)
  end
  
  def self.twitter2hash user
    hash = {}
    hash['id'] = user.id.to_s if user.id
    hash['notifications']=user.notifications if user.notifications
    hash['profile_background_image_url']=user.profile_background_image_url if user.profile_background_image_url
    hash['profile_image_url']=user.profile_image_url if user.profile_image_url
    hash['description']=user.description if user.description
    hash['lang']=user.lang if user.lang
    hash['statuses_count']=user.statuses_count.to_s if user.statuses_count
    hash['profile_sidebar_fill_color']=user.profile_sidebar_fill_color if user.profile_sidebar_fill_color
    hash['profile_background_tile']=user.profile_background_tile if user.profile_background_tile
    hash['screen_name']=user.screen_name if user.screen_name
    hash['contributors_enabled']=user.contributors_enabled if user.contributors_enabled
    hash['profile_sidebar_border_color']=user.profile_sidebar_border_color if user.profile_sidebar_border_color
    hash['following']=user.following if user.following
    hash['geo_enabled']=user.geo_enabled if user.geo_enabled
    hash['created_at']=user.created_at if user.created_at
    hash['followers_count']=user.followers_count.to_s if user.followers_count
    hash['friends_count']=user.friends_count.to_s if user.friends_count
    hash['verified']=user.verified if user.verified
    hash['profile_background_color']=user.profile_background_color if user.profile_background_color
    hash['favourites_count']=user.favourites_count.to_s if user.favourites_count
    hash['protected']=user.protected if user.protected
    hash['url']=user.url if user.url
    hash['profile_text_color']=user.profile_text_color if user.profile_text_color
    hash['name']=user.name if user.name
    hash['time_zone']=user.time_zone if user.time_zone
    hash['location']=user.location if user.location
    hash['utc_offset']=user.utc_offset.to_s if user.utc_offset
    hash['profile_link_color']=user.profile_link_color if user.profile_link_color
    hash
  end


end
