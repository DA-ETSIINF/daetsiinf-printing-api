class User < ApplicationRecord
  before_validation :generate_authentication_token!
  before_validation :generate_confirmation_token!

  validates :name, :email, :auth_token, :confirmation_token, :balance, presence: true
  validates :auth_token, :email, uniqueness: true
  devise :database_authenticatable

  after_create :send_confirmation_email

  has_many :folders, dependent: :destroy
  has_many :documents, dependent: :destroy

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def generate_confirmation_token!
    begin
      self.confirmation_token = Devise.friendly_token
    end while self.class.exists?(confirmation_token: confirmation_token)
  end

  def send_confirmation_email
    ConfirmationMailer.confirmation_mail(self).deliver
  end
end
