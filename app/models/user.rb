class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: Settings.user.name_max}
  validates :email, presence: true, length: {maximum: Settings.user.email_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password_min}, allow_nil: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
