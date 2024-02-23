# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(_auth_object = nil)
    %w[confirmation_sent_at confirmation_token confirmed_at created_at current_sign_in_at current_sign_in_ip email failed_attempts id last_sign_in_at last_sign_in_ip locked_at name
       remember_created_at reset_password_sent_at reset_password_token sign_in_count unconfirmed_email unlock_token updated_at]
  end
end
