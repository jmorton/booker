OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:developer, OmniAuth::AuthHash.new({
  provider: 'developer',
  uid: 'developer'
}))
