module Users
  class SubconUsersController < Users::Base
    def index
      # 自身が招待を受けたユーザーのid(自身の上にあたるユーザー) ※招待保留中
      @invitation_pending_to = User.invitation_pending_to(current_user)
      # 自身が招待を受けたユーザーのid(自身の上にあたるユーザー) ※招待済
      @invited_to = User.invited_to(current_user)

      # 自身が招待したユーザーid(自身の下請にあたるユーザー) ※招待保留中
      @invitation_pending_user_ids = current_user.invitation_sent_user_ids
      # 自身が招待したユーザーid(自身の下請にあたるユーザー) ※招待済
      @invited_user_ids = current_user.invited_user_ids
    end

    # 自身に届いた招待を承認する
    def approval
      # 自身が招待を受けたユーザー(自身の上にあたるユーザー)
      invited_user = Business.find_by(uuid: params[:id]).user
      pending_invitation = invited_user.invitation_sent_user_ids

      # 自身が招待を受けたユーザーinvitation_sent_user_idsカラムの配列から自信のユーザーidを取り除く。
      pending_invitation.delete(current_user.id)
      invited_user.update(invitation_sent_user_ids: pending_invitation)

      # 自身が招待を受けたユーザーのinvited_user_idsカラムの配列に自信のユーザーidを追加する。
      invited_user_invited_user = invited_user.invited_user_ids || []
      invited_user_invited_user << current_user.id
      invited_user.update(invited_user_ids: invited_user_invited_user)

      flash[:success] = "#{invited_user.business.name}様からの招待を承認しました。"
      redirect_to users_subcon_users_url
    end

    # 自身に届いている(自身が招待された)招待リクエストを破棄
    def destroy_invited_pending
      # 自身が招待を受けたユーザー(自身の上にあたるユーザー)
      invited_user = Business.find_by(uuid: params[:id]).user
      pending_invitation = invited_user.invitation_sent_user_ids

      # 自身が招待を受けたユーザーのinvitation_sent_user_idsカラムの配列から自身のユーザーidを取り除く。
      pending_invitation.delete(current_user.id)
      invited_user.update(invitation_sent_user_ids: pending_invitation)

      flash[:danger] = "#{invited_user.business.name}様からの招待リクエストを破棄しました。"
      redirect_to users_subcon_users_url
    end

    # 自身が送った招待リクエストを破棄
    def destroy_invitation_pending
      # 自身が招待を送ったユーザー(自身の下請けにあたるユーザー)
      invited_user = User.find(params[:id])
      pending_invitation = current_user.invitation_sent_user_ids

      pending_invitation.delete(invited_user.id)
      current_user.update(invitation_sent_user_ids: pending_invitation)

      flash[:danger] = "#{User.find(params[:id]).email}様への招待リクエストをキャンセルしました。"
      redirect_to users_subcon_users_url
    end

    # 自身の下請け協力会社を解除
    def destroy_invited
      invited_user = Business.find_by(uuid: params[:id]).user
      invitation = current_user.invited_user_ids

      invitation.delete(invited_user.id)
      current_user.update(invited_user_ids: invitation)

      flash[:danger] = "#{invited_user.business.name}様の協力会社登録を解除しました。"
      redirect_to users_subcon_users_url
    end
  end
end
