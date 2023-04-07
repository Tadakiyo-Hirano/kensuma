FactoryBot.define do
  factory :solvent do
    uuid { SecureRandom.uuid }
    name { 'TEST塗料液' }
    maker { 'TESTメーカー' }
    classification { 'エポキシ塗料' }
    ingredients { 'トルエン・MIBK' }
    business
  end
end
