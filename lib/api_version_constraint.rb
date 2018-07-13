class ApiVersionConstraint

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    #Versão default ou versão que o usuário específicou
    @default || req.headers['Accept'].include?("application/vnd.burajiru_ponto.v#{@version}")
  end

end