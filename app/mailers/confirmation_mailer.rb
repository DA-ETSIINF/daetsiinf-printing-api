class ConfirmationMailer < ApplicationMailer
  default :from => ENV['GMAIL-MAIL']

  def confirmation_mail(user)
    @user = user
    @url  = "http://localhost:3000/confirmations/#{user.confirmation_token}"
    mail(to: @user.email, subject: 'Confirmación de cuenta Servicio de Reprografía')
  end
end
