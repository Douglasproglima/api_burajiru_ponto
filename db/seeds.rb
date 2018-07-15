# Criando nossos Users
User.create email: 'admin@admin.com', password: 123456, password_confirmation: 123456

# TipoContrato.create descricao: 'Seishain(正社員)', obs: 'Funcionário efetivo', user_id: 1
# TipoContrato.create descricao: 'Hiseishain(非正社員)', obs: 'Funcionário não efetivo', user_id: 1
# TipoContrato.create descricao: 'Keiyaku shain(契約社員)', obs: 'Funcionário temporário', user_id: 1
# TipoContrato.create descricao: 'Haken shain(派遣社員)', obs: 'Funcionários terceirizados, alocados por empreiteiras', user_id: 1
# TipoContrato.create descricao: 'Part-timers e/ou Arubaito', obs: 'Trabalhadores temporários', user_id: 1
#
# Empresa.create razao_social: 'Empresa Teste 1', email: 'empresa.teste1@gmail.com', telefone_1: '+81 90 3265 9854', vlr_hora: 1400, percentual_hora_extra: 25, percentual_add_noturno: 25, tipo_contrato: 4
#
# EscalaTrabalho.create descricao: 'Nikotai', empresa_id: 1