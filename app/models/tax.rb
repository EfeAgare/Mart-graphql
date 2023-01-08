class Tax < ApplicationRecord
  validates :type, presence: true
  validates :percentage, presence: true
end
