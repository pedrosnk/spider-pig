# Author: Renato Fernandes de Queiroz

require 'twitter.rb'
require 'mongo'

class Oinker

  def initialize(db_name)
    @db = Mongo::Connection.new.db(db_name)
    @user_coll = @db.collection('tweeters')
    @status_coll = @db.collection('statuses')
    @relation_coll = @db.collection('relationships')
  end

  def syncronize(hash, deep=3)
    return nil if deep == 0

    twitter = Twitter.new(hash)
    user = twitter.user
    user_mongo = @user_coll.find_one(:screen_name => user['screen_name'])
    if (user_mongo)
      update_user(user_mongo['_id'], user)
      return user['_id']
    else
      save_user(user)
    end

    

    timeline = twitter.timeline

    timeline.each do |status|
      status.user = user['_id']
      @status_coll.insert(status.marshal_dump())
    end


    friends = twitter.friends
    friends.each do |id|
      begin
        mongoId = syncronize({:id => id}, deep - 1)
        @relation_coll.insert({:friend => user['_id'], :follower => mongoId}) if mongoId
      rescue 
        puts "Falha na colta de informacoes de " + id
      end
    end
    user['_id']
  end


  private

    def update_user(id, user)
      @user_coll.update({:_id => id}, user)
      user['_id'] = id
      user
    end

    def save_user(user)
      user['_id'] =  @user_coll.insert(user)
    end
end
