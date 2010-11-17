# Author: Renato Fernandes de Queiroz

$: << File.expand_path(File.dirname('main.rb') + '/../lib')

require 'yaml'
require 'oinker'

config = YAML.load_file('oinker.yml')
seeds = YAML.load_file('seeds.yml')

oinker = Oinker.new(config['oinker']['database'])


@mongo_conn = Mongo::Connection.new.db(config['oinker']['database'])
@seeds = @mongo_conn.collection('seeds')

@seeds.find().each { |seed| oinker.syncronize({:screen_name => seed['screen_name']}, config['oinker']['deep_level'])}

#seeds.each { |seed|  oinker.syncronize({:screen_name => seed}, config['oinker']['deep_level']) }

puts 'terminou'
  


