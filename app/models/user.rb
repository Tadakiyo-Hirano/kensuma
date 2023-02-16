# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, invite_for: 24.hours
  # :confirmable
  
  scope :invitation_sent_to, -> (user) {
    where("JSON_CONTAINS(invitation_sent_user_ids, ?, '$')", user.id.to_s)
  }
  # 例: User.invitation_sent_to(current_user) で自身に招待(未承認)してきたUserを取得

  has_many :articles, dependent: :destroy
  has_many :news_users, dependent: :destroy
  has_many :news, through: :news_users
  has_one :business, dependent: :destroy

  has_many :general_users, class_name: 'User', foreign_key: 'admin_user_id', dependent: :destroy
  belongs_to :admin_user, class_name: 'User', optional: true

  enum gender: { male: 0, female: 1, other: 2 }
  enum role: { admin: 0, general: 1 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name,  presence: true, length: { in: 1..10 }
  validates :age,   allow_nil: true, numericality: { greater_than_or_equal_to: 10 }
end
