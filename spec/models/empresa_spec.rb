require 'rails_helper'

RSpec.describe Empresa, type: :model do

  let(:empresa) { FactoryGirl.build(:empresa) }

  context 'Quando for novo' do
    # it { expect(empresa).not_to be_done }
  end

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of :razao_social }
  it { is_expected.to validate_presence_of :ativo }
  it { is_expected.to validate_presence_of :telefone_1 }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to respond_to(:razao_social) }
  it { is_expected.to respond_to(:telefone_1) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:ativo) }
  it { is_expected.to respond_to(:ativo) }

  it { is_expected.to respond_to(:user_id) }

end
