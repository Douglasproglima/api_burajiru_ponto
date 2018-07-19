DeviseTokenAuth.setup do |config|
  # Gera um token novo a cada requisição do usuário
  # config.change_headers_on_each_request = true

  # Tempo de validade que o último Token possui. No caso 2 semanas
  # config.token_lifespan = 2.weeks

  # Número máximo de dispositivos que podem que podem usar a conta de determinado user
  # config.max_number_of_devices = 5

  # Tempo que o devise irá considerar se a requisição é em lote ou não
  # config.batch_request_buffer_throttle = 5.seconds

  # Trabalha com rotas pré-definidas do omniauth
  # config.omniauth_prefix = "/omniauth"

  # Segurança, caso o user tente alterar a senha é necessário passar a senha atual.
  # config.check_current_password_before_update = :attributes

  # By default we will use callbacks for single omniauth.
  # It depends on fields like email, provider and uid.
  # config.default_callbacks = true

  # Nome do parâmetro que o devise envia na requisição, é possível alterar esse nome aqui.
  # config.headers_names = {:'access-token' => 'access-token',
  #                        :'client' => 'client',
  #                        :'expiry' => 'expiry',
  #                        :'uid' => 'uid',
  #                        :'token-type' => 'token-type' }

  # Pode integrar com outro tipo de autenticação legada etc...
  # config.enable_standard_devise_support = false
end
