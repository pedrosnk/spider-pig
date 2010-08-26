#require 'twitter_adapter'
require 'tweeter'

twitter_seed = ['renatofq', 'volmerius']


#twitter_seed.each do |seed|
#  twits = Twitter.new(seed, seed)
#  twits.bind
#end


home = Tweeter.new


home.load!(:screen_name => 'renatofq')

puts home.screen_name


