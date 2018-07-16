class Api::V2::BaseController < ApplicationController

  #Add a entrada de alguns métodos de entrada que o Devise irá precisar.
  include DeviseTokenAuth::Concerns::SetUserByToken

  include Authenticable
end