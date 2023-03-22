# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper
  include DocumentsHelper

  rescue_from StandardError, with: :handle_server_error if Rails.env.production?
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found if Rails.env.production?
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to users_dash_boards_path, alert: '画面を閲覧する権限がありません。'
  end

  def handle_not_found
    render 'errors/404error', layout: false
  end

  def handle_server_error(error)
    if Rails.env.production?
      ExceptionNotifier.notify_exception(error, env: request.env,
                                         data: {
                                           RAILS_ENV:    Rails.env,
                                           message:      error.message,
                                           current_user: current_user&.inspect
                                         }
      )
    end

    render 'errors/5XXerror', layout: false
  end

  def after_sign_in_path_for(resource)
    case resource
    when User
      resource.business.nil? ? new_users_business_url : users_orders_url
    when Admin
      _system__dashboard_path
    when Manager
      managers_dash_boards_url
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[email name password password_confirmation role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :invite, keys: added_attrs
    devise_parameter_sanitizer.permit :accept_invitation, keys: added_attrs
  end
end
