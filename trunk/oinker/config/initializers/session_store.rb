# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oinker_session',
  :secret      => '6ce4388cb30eecec26e449f92d06484973da4a8dc1a8706857a00ed484b88b31b18ed5596bac1ea1d507f8865db7fcdfe2e89aedbe7ebe6d0be8fba39518d008'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
