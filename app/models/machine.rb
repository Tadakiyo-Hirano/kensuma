class Machine < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  enum name: {
    electric_plane: 0,            # 電動カンナ
    electric_drill: 1,            # 電動ドリル
    electric_circular_saw: 2,     # 電動丸のこ
    grinder: 3,                   # グラインダー等
    arc_welding_machine: 4,       # アーク溶接機
    winch: 5,                     # ウインチ
    generator: 6,                 # 発電機
    trans: 7,                     # トランス
    compressor: 8,                # コンプレッサー
    blower: 9,                    # 送風機
    pump_class: 10,               # ポンプ類
    mixer_class: 11,              # ミキサー類
    conveyor: 12,                 # コンベヤー
    spraying_machine: 13,         # 吹付機
    bowling_machine: 14,          # ボーリングマシン
    vibration_compactor: 15,      # 振動コンパクター
    vibrator: 16,                 # バイブレーター
    rebar_processing_machine: 17, # 鉄筋加工機
    electric_chain_block: 18      # 電動チェーンブロック
  }, _prefix: true

  validates :name, presence: true
  validates :standards_performance, presence: true
  validates :control_number, presence: true
  validates :inspector, presence: true
  validates :handler, presence: true
  validates :inspection_date, presence: true

  def to_param
    uuid
  end
end
