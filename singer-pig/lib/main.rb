# Author: Renato Fernandes de Queiroz

$: << File.expand_path(File.dirname('main.rb') + '/../lib')

require 'yaml'
require 'oinker'

config = YAML.load_file('oinker.yml')
seeds = YAML.load_file('seeds.yml')

oinker = Oinker.new(config['oinker']['database'])

seeds.each { |seed|  oinker.syncronize({:screen_name => seed}, config['oinker']['deep_level']) }

puts 'terminou'
  


