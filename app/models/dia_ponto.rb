class DiaPonto < ApplicationRecord
  belongs_to :user
  belongs_to :parametro

  has_many :pontos, dependent: :destroy

  validates_presence_of :data, :user_id, :parametro_id
end
