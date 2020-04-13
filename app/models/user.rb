class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates(
    :name,
    {
      presence: true,
      length: { maximum: 99 }
    })
  validates(
    :email,
    {
      presence: true,
      length: { maximum: 99 },
      format: { with: /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i },
      uniqueness: { case_sensitive: false }
    })
  validates(
    :password,
    {
      presence: true,
      length: { minimum: 5 },
    })
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
