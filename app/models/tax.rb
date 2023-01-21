class Tax < ApplicationRecord
  self.inheritance_column = :zoink

  validates :type, presence: true
  validates :percentage, presence: true
end
