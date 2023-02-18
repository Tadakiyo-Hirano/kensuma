module Users
  class SubconUsersController < Users::Base
    def index
      # 自身に招待依頼(招待未承認)してきたユーザーid(自身の上にあたるユーザー)
      @invitation_pending_to = User.invitation_pending_to(current_user)
      # 自身に招待(招待承認済)してきたユーザーid(自身の上にあたるユーザー)
      @invited_to = User.invited_to(current_user)

      # 自身が招待した招待保留中のユーザーid(自身の下請にあたるユーザー)
      @invitation_pending_user_ids = current_user.invitation_sent_user_ids
      # 自身が招待した招待済のユーザーid(自身の下請にあたるユーザー)
      @invited_user_ids = current_user.invited_user_ids
    end

    def approval
      # 招待したユーザー(自身が招待を受けたユーザー)
      invited_user = Business.find_by(uuid: params[:id]).user
      invited_user_pending_invitation = invited_user.invitation_sent_user_ids

      # 招待承認(招待を受け入れ)後、招待したユーザー側の招待リクエスト中カラム(invitation_sent_user_ids)の配列から自信のユーザーidを削除する。
      invited_user_pending_invitation.delete(current_user.id)
      invited_user.update(invitation_sent_user_ids: invited_user_pending_invitation)
      
      # 招待承認(招待を受け入れ)後、招待したユーザー側の招待済カラム(invited_user_ids)の配列に自信のユーザーidを追加する。
      invited_user_invited_user = invited_user.invited_user_ids || []
      invited_user_invited_user << current_user.id
      invited_user.update(invited_user_ids: invited_user_invited_user)

      flash[:danger] = "テスト"
      redirect_to users_subcon_users_url
    end
  end
end
