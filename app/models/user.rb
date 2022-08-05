class User < ApplicationRecord
  has_secure_password

  has_many :products, foreign_key: "seller"
end
