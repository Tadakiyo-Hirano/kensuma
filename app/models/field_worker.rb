class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum sendoff_education: { educated: 0, not_educated: 1 }, _prefix: true       # 送り出し教育の受講有無
  validates :admission_worker_name, presence: true
  validates :content, presence: true
  validates :job_description, presence: true, if: -> {  age = "true" }

  def to_param
    uuid
  end

  def age
      birth_date = content['birth_day_on'].to_date
      str_date = admission_date_start.to_date # 入場日
        border_date = str_date.prev_year(18) # 入場日から18年前の日付
        if border_date < birth_date
          target_ids.push field_worker.id
          logger.debug("true")
          binding.pry
        end
  end

  def youth_field_workers?
    Time.zone.now < self.birthday_on.since(18.years)
  end
end
