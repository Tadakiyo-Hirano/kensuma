5.times do |n|
  Solvent.seed(:id,
    {
      id:                  n+1,
      business_id:         n+1,
      uuid:                SecureRandom.uuid,
      name:                "テスト100",
      maker:               "テストペイント",
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
      name:                "テスト塗料液",
      maker:               "テスト化学工業",
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
      name:                "シンナー",
      maker:               "テスト化学工業",
      classification:      "シンナー",
      ingredients:         "トルエン・キシレン",
    }
  )
end
