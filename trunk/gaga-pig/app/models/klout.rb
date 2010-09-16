class Klout
  include Mongoid::Document

  field :info
  field :influencedby
  field :influencerof

  embedded_in :tweeters, :inverse_of => :klout


end
