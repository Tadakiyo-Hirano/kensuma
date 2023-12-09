class BusinessIndustry < ApplicationRecord
  belongs_to :business
  belongs_to :industry
  before_save :set_construction_license_number

  enum construction_license_permission_type_minister_governor: { minister_permission: 0, governor_permission: 1 }, _prefix: true # 建設許可証(許可種別)
  enum construction_license_governor_permission_prefecture: { hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9, saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13, niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19, gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29, tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39, saga: 40, nagasaki: 41, kumamoto: 42, oita: 43, miyazaki: 44, kagoshima: 45, okinawa: 46 } # 建設許可証(都道府県)
  enum construction_license_permission_type_identification_general: { identification: 0, general: 1 }, _prefix: true # 建設許可証(許可種別)

  validates :construction_license_permission_type_minister_governor, presence: true, if: -> { business.construction_license_status == 'available' }
  validates :construction_license_governor_permission_prefecture, presence: true, if: -> { construction_license_permission_type_minister_governor == 'governor_permission' }
  validates :construction_license_permission_type_identification_general, presence: true, if: -> { business.construction_license_status == 'available' }
  validates :construction_license_number_double_digit, format: { with: /\A\d{1,2}\z/, message: 'は数字2桁以下で入力してください' }, presence: true, if: -> { business.construction_license_status == 'available' }
  validates :construction_license_number_six_digits, format: { with: /\A\d{1,6}\z/, message: 'は数字6桁以下で入力してください' }, presence: true, if: -> { business.construction_license_status == 'available' }
  validates :construction_license_updated_at, presence: true, if: -> { business.construction_license_status == 'available' }

  def set_construction_license_number
    self.construction_license_number = construction_license_number_string
  end

  # 建設許可証番号の組み合わせ表示
  def construction_license_number_string
    if construction_license_permission_type_minister_governor == 'governor_permission'
      "#{BusinessIndustry.construction_license_governor_permission_prefectures_i18n[construction_license_governor_permission_prefecture]}知事(#{construction_license_permission_type_identification_text(construction_license_permission_type_identification_general)}-#{construction_license_number_double_digit.to_s.rjust(2)})第#{construction_license_number_six_digits.to_s.rjust(6)}号".gsub(/第\s+/, '第')
    else
      "国土交通大臣(#{construction_license_permission_type_identification_text(construction_license_permission_type_identification_general)}-#{construction_license_number_double_digit.to_s.rjust(2)})第#{construction_license_number_six_digits.to_s.rjust(6)}号".gsub(/第\s+/, '第')
    end
  end

  private

  # 建設許可証の特定・一般の整形
  def construction_license_permission_type_identification_text(type)
    case type
    when 'identification'
      '特'
    when 'general'
      '般'
    else
      ''
    end
  end
end
