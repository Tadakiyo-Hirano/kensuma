class Industry < ApplicationRecord
  has_many :business_industries
  has_many :businesses, through: :business_industries
  has_many :occupations
end
