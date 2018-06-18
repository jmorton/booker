Rails.application.config.content_security_policy do |p|
  if Rails.env.development?
    p.default_src  :self, :http, :https, :unsafe_eval
    p.script_src   :self, :http, :unsafe_eval
    p.img_src      :self, :https, :data
    p.connect_src  :self, :http, 'http://localhost:3035', 'ws://localhost:3035'
  else
    p.default_src  :self, :https
    p.script_src   :self, :https
    p.img_src      :self, :https, :data, 'jonmorton.nyc3.digitaloceanspaces.com'
  end
end
