# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    layout :invitation_layout

    def invitation_layout
      if action_name == 'new' || action_name == 'create'
        'users'
      else
        'users_auth'
      end
    end

    # def new
    #   super
    # end

    def create
      self.resource = invite_resource
      resource_invited = resource.errors.empty?

      yield resource if block_given?

      if resource_invited
        if is_flashing_format? && self.resource.invitation_sent_at
          set_flash_message :notice, :send_instructions, email: self.resource.email
        end
        if self.method(:after_invite_path_for).arity == 1
          respond_with resource, location: after_invite_path_for(current_inviter)
        else
          respond_with resource, location: users_subcon_users_path
        end
      else
        respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
      end
    end

    # def edit
    #   super
    # end

    def update
      raw_invitation_token = update_resource_params[:invitation_token]
      self.resource = accept_resource
      invitation_accepted = resource.errors.empty?

      yield resource if block_given?

      if invitation_accepted
        if resource.class.allow_insecure_sign_in_after_accept
          flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
          set_flash_message :notice, flash_message if is_flashing_format?
          resource.after_database_authentication
          sign_in(resource_name, resource)
          respond_with resource, location: new_users_business_path
        else
          set_flash_message :notice, :updated_not_active if is_flashing_format?
          respond_with resource, location: new_session_path(resource_name)
        end
      else
        resource.invitation_token = raw_invitation_token
        respond_with_navigational(resource) { render :edit, status: :unprocessable_entity }
      end
    end

    # def destroy
    #   super
    # end
  end
end
