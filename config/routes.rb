require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: {sessions: 'api/v1/sessions'}

  #Rotas referente há API, caso necessário criar um namespace separado para a área administrativa
  #Exemplo: namespace :admin do ... end

  #O namespace abaixo dará acesso externo da seguinte forma subdmonain.site.com/corpo_namespace
  #O path. é necessário para acessar direto o subdomain, do contrário ficaria subdmonain.site.com/api/corpo_namespace

  #Configuração para uso local
  # namespace :api, default: {format: :json}, constraints: {subdomain: 'api'}, path: '/' do

  #Configuração para uso produção usando o domínio do Heroku
  namespace :api, default: {format: :json}, path: '/' do
    #API - Versão 1.0
    #Na pasta lib contém o arquivo de controle de constraints da API que possui a class ApiVersionConstraint
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1) do

      #Define a rotas do Sistema
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tipo_contratos, only: [:index, :show, :create, :update, :destroy]
      resources :empresas, only: [:index, :show, :create, :update, :destroy]
      resources :escala_trabalhos, only: [:index, :show, :create, :update, :destroy]
      resources :escala_trabalho_horarios, only: [:index, :show, :create, :update, :destroy]
      resources :parametros, only: [:index, :show, :create, :update, :destroy]
      resources :dia_pontos, only: [:index, :show, :create, :update, :destroy]
      resources :pontos, only: [:index, :show, :create, :update, :destroy]
    end

    #API - Versão 2.0
    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2, default: true) do

      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tipo_contratos, only: [:index, :show, :create, :update, :destroy]
      resources :empresas, only: [:index, :show, :create, :update, :destroy]
      resources :escala_trabalhos, only: [:index, :show, :create, :update, :destroy]
      resources :escala_trabalho_horarios, only: [:index, :show, :create, :update, :destroy]
      resources :parametros, only: [:index, :show, :create, :update, :destroy]
      resources :dia_pontos, only: [:index, :show, :create, :update, :destroy]
      resources :pontos, only: [:index, :show, :create, :update, :destroy]
    end
  end

end
