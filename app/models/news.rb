class News < ApplicationRecord
  has_many :news_users, dependent: :destroy
  has_many :users, through: :news_users
  before_create -> { self.uuid = SecureRandom.uuid }

  # default: 0
  enum status: { draft: 0, published: 1 }

  validates :title, presence: true, length: { in: 1..100 }
  validates :status, presence: true

  # custom validation methods
  validate :unable_to_be_published
  validate :news_must_be_delivered_before_now

  scope :unread, ->(user) { where.not(id: user.news.ids).published }

  def to_param
    uuid
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title status content created_at delivered_at id uuid]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[news_users users]
  end

  private

  def unable_to_be_published
    if !title.present? || !content.present? || !delivered_at.present? && (status == 'published')
      errors.add(:status, '「下書き(Draft)」から「公開(Published)」に変更したい場合は、全ての項目を入力してください。')
    end
  end

  def news_must_be_delivered_before_now
    if delivered_at > Time.now
      errors.add(:delivered_at, '配信日は本日または本日よりも前の日時に設定してください。')
    end
  end
end
