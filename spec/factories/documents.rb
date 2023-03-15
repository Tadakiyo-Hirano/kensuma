FactoryBot.define do
  factory :document do
    uuid { SecureRandom.uuid }
    document_type { 1 }
    created_on { '2022-03-08' }
    submitted_on { '2022-03-08' }
    content { }
    business
    request_order

    # 表紙
    trait :cover do
      document_type { 1 }
      content { {} }
    end

    # 目次
    trait :table do
      document_type { 2 }
      content { {} }
    end

    # 施工体制台帳作成建設工事の通知
    trait :doc_3rd do
      document_type { 3 }
      content { {} }
    end

    # 作業員名簿
    trait :doc_8th do
      document_type { 8 }
      content { {} }
    end

    # 工事安全衛生計画書
    trait :doc_19th do
      document_type { 19 }
      content { {} }
    end

    # 新規入場時等教育実施報告書
    trait :doc_21st do
      document_type { 21 }
      content { {} }
    end
  end

  factory :document_first_sub do
    uuid { SecureRandom.uuid }
    document_type { 1 }
    created_on { '2022-03-08' }
    submitted_on { '2022-03-08' }
    content { }
    business
    request_order

    # 工事安全衛生計画書
    trait :doc_19th do
      document_type { 19 }
      content { {} }
    end

    # 新規入場時等教育実施報告書
    trait :doc_21st do
      document_type { 21 }
      content { {} }
    end
  end
end
