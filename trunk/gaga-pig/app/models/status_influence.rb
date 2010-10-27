class StatusInfluence
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :user
  field :text
  
end
