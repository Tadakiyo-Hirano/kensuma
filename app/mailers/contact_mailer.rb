class ContactMailer < ApplicationMailer
  def invitation_email(user)
    @user = user
    mail(to: @user.email, subject: '【建スマ】協力会社承認のお願い')
  end
end
