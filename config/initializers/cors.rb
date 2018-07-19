# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # No caso do * vc está permitindo que esse domínio tenha acesso a todos os recurso do resources
    origins '*'

    resource '*',
             :headers => :any,
             :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
             :methods => [:get, :post, :options, :delete, :put]
  end
end

#Exemplo mais completo que deve ser usado em produção
# use Rack::Cors do
#   allow do
#     origins 'localhost:3000', '127.0.0.1:3000',
#             /http:\/\/192\.168\.0\.\d{1,3}(:\d+)?/
#             # regular expressions can be used here
#
#     resource '/file/list_all/', :headers => 'x-domain-token'
#     resource '/file/at/*',
#         :methods => [:get, :post, :put, :delete, :options],
#         :headers => 'x-domain-token',
#         :expose  => ['Some-Custom-Response-Header'],
#         :max_age => 600
#         # headers to expose
#   end
#
#   allow do
#     origins '*'
#     resource '/public/*', :headers => :any, :methods => :get
#   end
# end