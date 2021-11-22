class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :profile, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w\-.+]+@[a-z\-\d.]+\.[a-z]+\z/i.freeze
  before_save :downcase_email
  validates :email, format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false},
                    length: {maximum: Settings.model.user.email_max},
                    presence: true,
                    allow_blank: true
  validates :password,  length: {minimum: Settings.model.user.password_min},
                        presence: true,
                        allow_blank: true
  has_secure_password

  enum role: {user: 0, admin: 1}

  private

  def downcase_email
    self.email = email.downcase
  end
end
