class Klout
  include Mongoid::Document

  field :classification, :type => Integer

  embedded_in :tweet, :inverse_of => :klout


end
