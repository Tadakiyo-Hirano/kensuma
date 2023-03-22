class BusinessIndustry < ApplicationRecord
  belongs_to :business
  belongs_to :industry

  enum construction_license_permission_type_minister_governor: { minister_permission: 0, governor_permission: 1 }, _prefix: true # 建設許可証(許可種別)
  enum construction_license_governor_permission_prefecture: { hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9, saitama: 10, chiba: 11, tokyo: 12, kanagawa: 13, niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19, gifu: 20, shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29, tottori: 30, shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39, saga: 40, nagasaki: 41, kumamoto: 42, oita: 43, miyazaki: 44, kagoshima: 45, okinawa: 46 } # 建設許可証(都道府県)
  enum construction_license_permission_type_identification_general: { identification: 0, general: 1 }, _prefix: true # 建設許可証(許可種別)

  validates :construction_license_permission_type_minister_governor, presence: true
  validates :construction_license_governor_permission_prefecture, presence: true
  validates :construction_license_permission_type_identification_general, presence: true
  validates :construction_license_number_double_digit, format: { with: /\A\d{2}\z/, message: 'は数字2桁で入力してください' }, presence: true
  validates :construction_license_number_six_digits, format: { with: /\A\d{1,6}\z/, message: 'は数字6桁以下で入力してください' }, presence: true
  validates :construction_license_number, presence: true
  validates :construction_license_updated_at, presence: true

end
