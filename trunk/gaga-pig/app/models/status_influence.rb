class StatusInfluence
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :influence_number
  field :statuses, :type => Statuses
  
end
