class ContactMailer < ApplicationMailer
  def invitation_email(invitation_user, current_user)
    @invitation_user = invitation_user
    @user = current_user
    @root = root_url
    mail(to: @invitation_user.email, subject: '【建スマ】協力会社承認のお願い')
  end
end
