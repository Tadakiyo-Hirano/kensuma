3.times do |n|
  Order.seed(:id,
    {
      id: n+1,
      business_id:     1,
      # status:          0,
      site_uu_id:      SecureRandom.uuid,
      site_name:       "現場#{n+1}",
      order_name:      "発注者#{n+1}",
      order_post_code: "123456#{n+1}",
      order_address:   "埼玉県発注市1-2-#{n+1}",

      site_career_up_id:                          "123456789#{rand(10000..99999)}",
      site_address:                               "埼玉県現場市2-3-#{n+1}",
      order_supervisor_name:                      "発注監督員名#{n+1}",
      order_supervisor_company:                   "発注監督会社#{n+1}",
      order_supervisor_apply:                     ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      construction_name:                          "工事名#{n+1}",
      construction_details:                       "工事内容#{n+1}",
      start_date:                                 Date.today,
      end_date:                                   Date.today.next_month,
      contract_date:                              Date.today.prev_month,
      submission_destination:                     "提出部･提出先名#{n+1}",
      health_and_safety_manager_name:             "元方安全衛生管理者名#{n+1}",
      supervisor_name:                            "現場監督員名#{n+1}",
      supervisor_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      site_agent_name:                            "現場代理人名#{n+1}",
      site_agent_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      supervising_engineer_name:                  "監督技術者･主任技術者名#{n+1}",
      supervising_engineer_check:                 0,
      supervising_engineer_assistant_name:        "監督技術者補佐名#{n+1}",
    }
  )
end

3.times do |n|
  Order.seed(:id,
    {
      id: n+4,
      business_id:     2,
      # status:          0,
      site_uu_id:      SecureRandom.uuid,
      site_name:       "現場#{n+4}",
      order_name:      "発注者#{n+4}",
      order_post_code: "123456#{n+4}",
      order_address:   "埼玉県発注市1-2-#{n+4}",

      site_career_up_id:                          "123456789#{rand(10000..99999)}",
      site_address:                               "埼玉県現場市2-3-#{n+1}",
      order_supervisor_name:                      "発注監督員名#{n+1}",
      order_supervisor_company:                   "発注監督会社#{n+1}",
      order_supervisor_apply:                     ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      construction_name:                          "工事名#{n+1}",
      construction_details:                       "工事内容#{n+1}",
      start_date:                                 Date.today,
      end_date:                                   Date.today.next_month,
      contract_date:                              Date.today.prev_month,
      submission_destination:                     "提出部･提出先名#{n+1}",
      health_and_safety_manager_name:             "元方安全衛生管理者名#{n+1}",
      supervisor_name:                            "現場監督員名#{n+1}",
      supervisor_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      site_agent_name:                            "現場代理人名#{n+1}",
      site_agent_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      supervising_engineer_name:                  "監督技術者･主任技術者名#{n+1}",
      supervising_engineer_check:                 0,
      supervising_engineer_assistant_name:        "監督技術者補佐名#{n+1}",
    }
  )
end

3.times do |n|
  Order.seed(:id,
    {
      id: n+7,
      business_id:     3,
      # status:          0,
      site_uu_id:      SecureRandom.uuid,
      site_name:       "現場#{n+7}",
      order_name:      "発注者#{n+7}",
      order_post_code: "123456#{n+7}",
      order_address:   "埼玉県発注市1-2-#{n+7}",

      site_career_up_id:                          "123456789#{rand(10000..99999)}",
      site_address:                               "埼玉県現場市2-3-#{n+1}",
      order_supervisor_name:                      "発注監督員名#{n+1}",
      order_supervisor_company:                   "発注監督会社#{n+1}",
      order_supervisor_apply:                     ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      construction_name:                          "工事名#{n+1}",
      construction_details:                       "工事内容#{n+1}",
      start_date:                                 Date.today,
      end_date:                                   Date.today.next_month,
      contract_date:                              Date.today.prev_month,
      submission_destination:                     "提出部･提出先名#{n+1}",
      health_and_safety_manager_name:             "元方安全衛生管理者名#{n+1}",
      supervisor_name:                            "現場監督員名#{n+1}",
      supervisor_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      site_agent_name:                            "現場代理人名#{n+1}",
      site_agent_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      supervising_engineer_name:                  "監督技術者･主任技術者名#{n+1}",
      supervising_engineer_check:                 0,
      supervising_engineer_assistant_name:        "監督技術者補佐名#{n+1}",
    }
  )
end

3.times do |n|
  Order.seed(:id,
    {
      id: n+10,
      business_id:     4,
      # status:          0,
      site_uu_id:      SecureRandom.uuid,
      site_name:       "現場#{n+10}",
      order_name:      "発注者#{n+10}",
      order_post_code: "123456#{n+10}",
      order_address:   "埼玉県発注市1-2-#{n+10}",

      site_career_up_id:                          "123456789#{rand(10000..99999)}",
      site_address:                               "埼玉県現場市2-3-#{n+1}",
      order_supervisor_name:                      "発注監督員名#{n+1}",
      order_supervisor_company:                   "発注監督会社#{n+1}",
      order_supervisor_apply:                     ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      construction_name:                          "工事名#{n+1}",
      construction_details:                       "工事内容#{n+1}",
      start_date:                                 Date.today,
      end_date:                                   Date.today.next_month,
      contract_date:                              Date.today.prev_month,
      submission_destination:                     "提出部･提出先名#{n+1}",
      health_and_safety_manager_name:             "元方安全衛生管理者名#{n+1}",
      supervisor_name:                            "現場監督員名#{n+1}",
      supervisor_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      site_agent_name:                            "現場代理人名#{n+1}",
      site_agent_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      supervising_engineer_name:                  "監督技術者･主任技術者名#{n+1}",
      supervising_engineer_check:                 0,
      supervising_engineer_assistant_name:        "監督技術者補佐名#{n+1}",
    }
  )
end

3.times do |n|
  Order.seed(:id,
    {
      id: n+13,
      business_id:     5,
      # status:          0,
      site_uu_id:      SecureRandom.uuid,
      site_name:       "現場#{n+13}",
      order_name:      "発注者#{n+13}",
      order_post_code: "123456#{n+13}",
      order_address:   "埼玉県発注市1-2-#{n+13}",

      site_career_up_id:                          "123456789#{rand(10000..99999)}",
      site_address:                               "埼玉県現場市2-3-#{n+1}",
      order_supervisor_name:                      "発注監督員名#{n+1}",
      order_supervisor_company:                   "発注監督会社#{n+1}",
      order_supervisor_apply:                     ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      construction_name:                          "工事名#{n+1}",
      construction_details:                       "工事内容#{n+1}",
      start_date:                                 Date.today,
      end_date:                                   Date.today.next_month,
      contract_date:                              Date.today.prev_month,
      submission_destination:                     "提出部･提出先名#{n+1}",
      health_and_safety_manager_name:             "元方安全衛生管理者名#{n+1}",
      supervisor_name:                            "現場監督員名#{n+1}",
      supervisor_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      site_agent_name:                            "現場代理人名#{n+1}",
      site_agent_apply:                           ["基本契約約款の通り", "契約書に準拠する", "口頭及び文書による"].sample,
      supervising_engineer_name:                  "監督技術者･主任技術者名#{n+1}",
      supervising_engineer_check:                 0,
      supervising_engineer_assistant_name:        "監督技術者補佐名#{n+1}",
    }
  )
end
