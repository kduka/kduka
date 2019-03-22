# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

if ENV["FOG_MOCK"] == "true"
  Fog.mock!
end

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :joyent_username => "joyentuser",
    :joyent_keyfile => "~/.ssh/id_rsa",
    :joyent_keyname => "joyentuser"
  }.merge(Fog.credentials)
end
