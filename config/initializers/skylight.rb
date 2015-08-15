Skylight.application: ENV["skylight_application_id"]
Skylight.authentication: ENV["skylight_authentication_token"]

production:
  Skylight.authentication = ENV["skylight_production_auth_token"]


