Rails.application.config.content_security_policy do |p|
  if Rails.env.development?
    p.script_src   :self, :http, :unsafe_eval
    p.default_src  :self, :http, :unsafe_eval
    p.connect_src  :self, :http, 'http://localhost:3035', 'ws://localhost:3035'
  else
    p.script_src   :self, :https
    p.default_src  :self, :https
  end
end
