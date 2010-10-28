# Author: Renato Fernandes de Queiroz

require 'twitter.rb'
require 'mongo'
require 'logger'

class Oinker

  $logger = Logger.new('oinker.log', 'weekly')
  $logger.level = Logger::DEBUG


  def initialize(db_name)
    @twitter = Twitter.new(db_name)
  end

  def syncronize(hash, deep=3)
    return nil if deep == 0

    @twitter.sync(hash)
   
    friends = @twitter.friends
    friends.each do |id|
      begin
        syncronize({:id => id}, deep - 1)
      rescue 
        $logger.warn("Falha na colta de informacoes de " + id.to_s)
      end
    end
    @twitter.user['_id']
  end
end
