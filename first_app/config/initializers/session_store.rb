# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_webcrawler_session',
  :secret      => '3841f882a4574616cfb019176f9ab4992d762d9d9f8ec03a86a06850e3c9ce4b0a1f0acf40c7b9d5187a4699fb4862aac1cc3fb4fb1a76d77915f98459473040'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
