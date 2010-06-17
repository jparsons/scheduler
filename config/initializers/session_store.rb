# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scheduler_session',
  :secret      => 'f30279a771ef143fbd91d19aa336075b080247912ef767c4f8a8fc8b722726dd01d5744f707640e61683cf148df6308e62709e14a5cd2c5ef18610213daeefa6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
