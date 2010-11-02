require 'mongo'

db = Mongo::Connection.new.db('spider-pig')
user_coll = db.collection('tweeters')
status_coll = db.collection('statuses')
relation_coll = db.collection('relationships')

user_coll.remove()
status_coll.remove()
relation_coll.remove()

user_coll.create_index("screen_name", {:unique => true} )
user_coll.create_index("tweeter_id", {:unique => true})

status_coll.create_index("id_str", {:unique => true})



