require 'rails_helper'

RSpec.describe User, type: :model do
  #OS TESTES REALIZADOS NESSA ETAPA SÃO SOMENTE EM MEMÓRIA

  #1 - Abaixo a primera implementação de testes realizados
  # before { @user = FactoryGirl.build(:user) }
  #
  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation) }
  # it { expect(@user).to be_valid }

  #2 - Abaixo a segunda forma dos testes realizados
  #subject { FactoryGirl.build(:user) }
  #it { expect(subject).to respond_to(:email) }
  #it { expect(subject).to be_valid }

  #3 - Abaixo a tercceira forma dos testes realizados
  #it { is_expected.to respond_to(:email)}

  #4 - Abaixo a quarta forma dos testes realizados
  # let(:user) {FactoryGirl.build(:user)}
  # it { expect(user).to respond_to(:email) }
  #
  # context 'Teste: Quando o nome do usuário é branco' do
  #   before {user.name = " "}
  #
  #   it {expect(user).not_to be_valid}
  # end
  #
  # context 'Teste: Quando o nome do usuário for NULL' do
  #   before {user.name = nil}
  #
  #   it {expect(user).not_to be_valid}
  # end

  #5 - Abaixo a quinta forma dos testes realizados, a forma abaixo resume as anteriores com menos código

  let(:user) {FactoryGirl.build(:user)}

  #Teste ao qual o usuário poderá ter muitas:
  # Contas, Movimentos e Movimento X Contas

  # OBS: O destroy garante que ao excluir o usuário, todos os registros referentes as entidades
  # relacionadas serão excluídas.
  it { is_expected.to have_many(:contas).dependent(:destroy) }
  it { is_expected.to have_many(:empresas).dependent(:destroy) }
  it { is_expected.to have_many(:movimentos).dependent(:destroy) }
  it { is_expected.to have_many(:movimento_contas).dependent(:destroy) }

  #it { is_expected.to  validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('admin@admin.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'Retorna e-mail, data de criação e o token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end

  describe '#generate_authentication_token!' do
    it 'Generates com chave única auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'Generates outro auth token quando o corrente auth token já foi inserido.' do
      allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcXYZ123456789')

      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end