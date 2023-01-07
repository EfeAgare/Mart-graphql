class Audit < ApplicationRecord
  belongs_to :order

  validates :message, presence: true
  validates :message, presence: true
  validates :code, presence: true
end
