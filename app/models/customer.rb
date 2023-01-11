class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL =/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze

  VALID_PASSWORD = /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}/
  validates :name, presence: true, length: { maximum: 100 }, format: { with: /[a-zA-Z]/}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

  validates :mobile_phone_2, phone: { possible: true, allow_blank: true }
  validates :mobile_phone, phone: { possible: true, allow_blank: true }

end
