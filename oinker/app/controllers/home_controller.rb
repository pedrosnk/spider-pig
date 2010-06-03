class HomeController < ApplicationController
  require 'grackle'

  def index
    @tweeter = Tweeter.new
  end

  def insert
    client = Grackle::Client.new
    tmp = client.users.show?(:screen_name => params[:tweeter][:screen_name])
    tweeter = Tweeter.new
    tweeter.created_at = tmp.created_at
    tweeter.friends_count = tmp.friends_count
    tweeter.profile_image_url = tmp.profile_image_url
    tweeter.followers_count = tmp.followers_count
    tweeter.screen_name = tmp.screen_name
    tweeter.location = tmp.location
    tweeter.geo_enabled = tmp.geo_enabled
    tweeter.time_zone = tmp.time_zone
    tweeter.protected = tmp.protected
    tweeter.description = tmp.description
    tweeter.profile_background_image_url = tmp.profile_background_image_url
    tweeter.url = tmp.url
    tweeter.statuses_count = tmp.statuses_count

    tweeter.save!
    
    redirect_to root_path
  end
end
