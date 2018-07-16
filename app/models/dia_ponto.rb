class DiaPonto < ApplicationRecord
  belongs_to :user
  belongs_to :parametro

  validates_presence_of :data, :user_id, :parametro_id
end
