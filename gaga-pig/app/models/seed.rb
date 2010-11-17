class Seed
  include Mongoid::Document
  include Mongoid::Timestamps
  field :screen_name, :type => String
  
  attr_accessible :screen_name
  
  validates_uniqueness_of :screen_name, :message => 'Usuario ja monitorado'
  
end
