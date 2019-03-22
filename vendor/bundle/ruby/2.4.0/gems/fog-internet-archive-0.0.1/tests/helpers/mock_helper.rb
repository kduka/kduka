# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

Fog.mock! if ENV["FOG_MOCK"] == "true"

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    ia_access_key_id: "fake_id",
    ia_secret_access_key: "fake_key",
  }.merge(Fog.credentials)
end
