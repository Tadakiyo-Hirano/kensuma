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
      # 既存ユーザーに対してはアカウント発行&招待処理は行わず、招待リクエストのお知らせメールのみ送信する
      user = User.find_by(email: params[:user][:email])
      if user.present? && user.invitation_accepted_at.present? || user.present? && user.invitation_token.nil? && user.invitation_accepted_at.nil?
        # 自信から招待を送ったユーザー
        invite_email = params[:user][:email]
        invite_user = User.find_by(email: invite_email)

        # 自身のメールアドレスにはメールを送信しない
        unless invite_email == current_user.email
          # すでに招待承認済のアカウントには招待しない
          unless current_user.invited_user_ids.include?(invite_user.id)
            # invitation_sent_user_idsから配列を取得
            current_user_invitation_sent_user = current_user.invitation_sent_user_ids || []
            # 配列に招待リクエストしたユーザーidを追加
            current_user_invitation_sent_user << invite_user.id
            # 更新した配列をinvitation_sent_user_idsカラムに保存
            current_user.update(invitation_sent_user_ids: current_user_invitation_sent_user.uniq)

            ContactMailer.invitation_email(invite_user).deliver_now
            redirect_to users_subcon_users_url, success: "招待リクエストが#{invite_user.id}【#{invite_user.business&.name}(#{invite_email})様】へ送信されました。"
          end
          redirect_to new_user_invitation_url, danger: "#{invite_email}はすでに招待承認済のアカウントです"
        else
          redirect_to new_user_invitation_url, danger: '自分のアカウントは招待できません'
        end
      else
        # アカウント未登録者には"devise_invitable"gem機能から招待メールを送信する
        self.resource = invite_resource
        if resource.errors.empty?
        
        # 配列に招待リクエストしたユーザーidを追加
        current_user.invitation_sent_user_ids << resource.id
        # 更新した配列をinvitation_sent_user_idsカラムに保存
        current_user.update(invitation_sent_user_ids: current_user.invitation_sent_user_ids.uniq)

          if is_flashing_format? && self.resource.invitation_sent_at
            set_flash_message :notice, :send_instructions, email: self.resource.email
          end
          if self.method(:after_invite_path_for).arity == 1
            respond_with resource, location:  users_subcon_users_url
          else
            respond_with resource, location:  users_subcon_users_url
          end
        else
          respond_with_navigational(resource) { render :new, status: :unprocessable_entity }
        end
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
