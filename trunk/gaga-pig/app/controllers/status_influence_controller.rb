class StatusInfluenceController < ApplicationController
  
  
  def index
    @status_influence = StatusInfluence.find(:all)
  end
  
  def msg
    @status_influence = StatusInfluence.find(:first, :conditions => {:_id => params[:id_str]})
    update_status_influence @status_influence
    @status_influence = StatusInfluence.find(:first, :conditions => {:_id => params[:id_str]})
  end

  def auth
    omniauth = YAML::load( request.env["rack.auth"].to_yaml )
    session[:twitter_token] = omniauth['credentials']['token']
    session[:twitter_token_secret] = omniauth['credentials']['secret']

    p session[:twitter_token_secret]
    p session[:twitter_token]
    redirect_to status_influence_new_msg_path
  end

  def new_msg
    @status_influence = StatusInfluence.new
    
    
    if params[:text]
      flash[:notice] = 'tentando salvar mensagem'
      client = get_grackle_client
      update = client.statuses.update! :status=>params[:text]
      if createStatusInfluence(update)
        flash[:notice] = 'Mensagem cadastrada'
      else
        flash[:notice] = 'falha no processo'
      end
    else
      flash[:notice] = 'escreva uma msg para o bilionariodf usar'
# pemedeiros... pra uso apenas quando token expirar
#      redirect_to 'http://localhost:3000/auth/twitter' unless session[:twitter_token]
#   client.statuses.show.json? :id => '4918107499921408' 4later =D
    end
  end
  
  private
  
  def createStatusInfluence(update_tweet)
    status_influence = StatusInfluence.find(:first, :conditions => {:_id => update_tweet.user.id_str})
    if not status_influence
      status_influence = StatusInfluence.new
      statuses = Statuses.new
    else
      statuses = status_influence.statuses
    end
    statuses.text                       = update_tweet.text
    statuses.geo                        = update_tweet.geo
    statuses.favorited                  = update_tweet.favorited
    statuses.in_reply_to_status_id      = update_tweet.in_reply_to_status_id_str
    statuses.in_reply_to_user_id        = update_tweet.in_reply_to_user_id
    statuses.contributors               = update_tweet.contributors
    statuses.in_reply_to_screen_name    = update_tweet.in_reply_to_screen_name
    statuses.created_at                 = update_tweet.created_at
    statuses.id_str                     = update_tweet.id_str
    statuses.retweet_count              = update_tweet.retweet_count
    statuses.coordinates                = update_tweet.coordinates
    statuses.retweeted                  = update_tweet.retweeted
    statuses.place                      = update_tweet.place
    statuses.user                       = update_tweet.user.id_str
    statuses.user_name                  = update_tweet.user.screen_name
    status_influence.statuses           = statuses
    status_influence._id                = statuses.id_str 
    status_influence.influence_number   = update_tweet.user.friends
    
    status_influence.save
#    status_influence.update_attributes(status_influence)

  end

  def update_status_influence(status_influence)
     client = get_grackle_client
     update = client.statuses.show.json? :id => status_influence.statuses.id_str
     createStatusInfluence(update)
  end
  
  def get_grackle_client
    consumer_data = YAML::load( File.open('config/twitter_app.yml') )
    client = Grackle::Client.new(:auth=>{
        :type=>:oauth,
        :consumer_key=> consumer_data['consumer_key'], :consumer_secret=>consumer_data['consumer_secret'],
        :token=> '210929105-fLBmgrkKTITdzn1xTtNdNaxVWUnwp6O4vqhESDso', :token_secret => '9UZvoYQoDuRU46cC58iosWOU8fzA1ZsbEM6mg84B8'
      })
    client
  end

end
