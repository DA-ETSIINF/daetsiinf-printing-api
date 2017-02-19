class User < ApplicationRecord
  validates :auth_token, uniqueness: true
  devise :database_authenticatable
  before_validation :generate_authentication_token!
  before_create :generate_confirmation_token!
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
