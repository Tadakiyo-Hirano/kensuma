class Industry < ApplicationRecord
  has_many :business_industries
  has_many :business, through: :business_industries
  has_many :occupations 
end
