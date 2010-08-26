  require 'cassandra'
  require 'grackle'


class TwitterModel


  def initialize
    @store = Cassandra.new('spider-pig')
    @client  = Grackle::Client.new
    @hash = {}
  end

  def method_missing (m, *args, &block)
    key = m.to_s
    if @hash[key]
      return @hash[key]
    else
      super
    end
  end
  
end
