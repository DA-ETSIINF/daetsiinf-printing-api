class ConfirmationMailer < ApplicationMailer
  default :from => ENV['GMAIL_MAIL']

  def confirmation_mail(user)
    @user = user
    #@url  = "daetsiinf-printing.herokuapp.com/confirmations/#{user.confirmation_token}"
    @url  = "localhost:3000/confirmations/#{user.confirmation_token}"
    mail(to: @user.email, subject: 'Confirmación de cuenta Servicio de Reprografía')
  end
end
