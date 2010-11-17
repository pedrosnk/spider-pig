# Author: Renato Fernandes de Queiroz

require 'grackle'
require 'mechanize'

class Twitter
  
  attr_reader :user
  attr_reader :timeline
  attr_reader :friends

  def initialize (db_name)
    @mongo = Mongo::Connection.new.db(db_name)
    @twitter = Grackle::Client.new
    @user_coll = @mongo.collection('tweeters')
    @status_coll = @mongo.collection('statuses')
    @relation_coll = @mongo.collection('relationships')
  end

  def sync(hash)
    @user = query_user(hash)
    mongo_user = @user_coll.find_one({'screen_name' => @user[:screen_name]})
    @user[:_id] = mongo_user['_id'] unless mongo_user.nil?
    @user[:_id] = store_user(@user)
    @timeline = query_timeline(hash, mongo_user.nil?)
    store_timeline(timeline, @user[:_id])
    @friends = query_friends(hash)
    nil
  end

  def add_friend

  end

  private
  def query_user (hash)
    user_data = nil
    secure_request {
      $logger.debug("looking for user...")
      user_data = @twitter.users.show.json?(hash)
      $logger.debug("done!")
    }
    user_data.delete_field('status')
#    user_data.klout = information_about_user_klout(user_data.screen_name)
    user_data.twittercounter = information_about_user_twittercounter(user_data.screen_name)
    user = user_data.marshal_dump()
    user[:tweeter_id] = user_data.id
    user
  end

  def store_user(user)
    @user_coll.save(user)
  end

  def query_timeline (hash, is_new_user)
    timeline = []
    params = hash.clone
    params[:count] = 200 if is_new_user
    params[:trim_user] = true
    secure_request {
      $logger.debug("looking for timeline...")
      timeline = @twitter.statuses.user_timeline.json?(params)
      $logger.debug("done!")
    }
    timeline
  end

  def store_timeline(timeline, user_id)
    timeline.each do |status|
      status.user = user_id
      @status_coll.insert(status.marshal_dump())
    end
  end

  def query_friends(hash)
    friends = []
    secure_request() {
      $logger.debug("looking for friends...")
      friends = @twitter.friends.ids.json?(hash)
      $logger.debug("done!")
    }
    friends
  end


  def information_about_user_twittercounter(search_name)
    $logger.debug("looking for twitter counter...")
    search_url = "http://twittercounter.com/" + search_name

    count_agente = Mechanize.new
    count_agente.get(search_url)

    stats = {}

    stats[:followers] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[1]/div").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:followers_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:followers_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

    stats[:following] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[2]/div").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:following_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:following_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

    stats[:tweets] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[3]/div").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:tweets_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
    stats[:tweets_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

    $logger.debug("done!")

    stats
  end

  def information_about_user_klout(search_name)
    $logger.debug("looking for klout...")
    search_url = "http://klout.com/" + search_name


    klout_agente = Mechanize.new
    klout_agente.get(search_url)

    klout = {}
    klout[:info] = klout_agente.page.search(".primary a").to_s.gsub(/<\/?[^>]*>/, "").gsub(/klout score/,"")

    klout[:influencedby] = Array.new
    klout[:influencerof] = Array.new
    5.times do |i|

      klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
      if klout_influencedby.empty?
        klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
        if not klout_influencedby.empty?
          klout[:influencedby] << klout_influencedby
        end
      else
        klout[:influencedby] << klout_influencedby
      end

      klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
      if klout_influencerof.empty?
        klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
        if not klout_influencerof.empty?
          klout[:influencerof] << klout_influencerof
        end
      else
        klout[:influencerof] << klout_influencerof
      end

    end

    $logger.debug("done!")

    klout
  end


  def secure_store &block
    begin
      yield block
    rescue Mongo::OperationFailure => error
      puts error
    end
  end


  def secure_request &block
    try_request = true
    while(try_request)
      begin
        try_request = false
        yield block
      rescue Grackle::TwitterError => error
        $logger.warn("Falha na requisicao")
        $logger.warn("Erro: #{error.status} Mensagem: #{error.response_body}")
        case error.status
        when 400, 403, 420, 502, 503
          $logger.info("Dormindo por 1h")
          sleep(3600)
          try_request = true
        when 401, 404, 406
          $logger.info("Prosseguindo")
        else
          $logger.fatal("Erro desconhecido")
        end
      end
    end
  end


end
