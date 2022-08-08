FactoryBot.define do
  factory :solvent do
    uuid { SecureRandom.uuid }
    name { 'TEST塗料液' }
    maker { 'TEST化学工業' }
    classification { 'エポキシ塗料' }
    ingredients { 'トルエン・MIBK' }
    business
  end
end
