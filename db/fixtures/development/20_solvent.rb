5.times do |n|
  Solvent.seed(:id,
    {
      id:                  n+1,
      business_id:         n+1,
      uuid:                SecureRandom.uuid,
      name:                "テストペイント　テスト100",
      maker:               "三菱化学",
      classification:      "塩ビ塗料",
      ingredients:         "トルエン・キシレン",
    }
  )
end

5.times do |n|
  Solvent.seed(:id,
    {
      id:                  n+6,
      business_id:         n+1,
      uuid:                SecureRandom.uuid,
      name:                "テスト化学工業　テスト塗料液",
      maker:               "山一化学",
      classification:      "エポキシ塗料",
      ingredients:         "トルエン・MIBK",
    }
  )
end

5.times do |n|
  Solvent.seed(:id,
    {
      id:                  n+11,
      business_id:         n+1,
      uuid:                SecureRandom.uuid,
      name:                "テスト化学工業　シンナー",
      maker:               "新日本化学",
      classification:      "シンナー",
      ingredients:         "トルエン・キシレン",
    }
  )
end
