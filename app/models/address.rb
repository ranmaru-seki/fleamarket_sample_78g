class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :for_family_name, :for_first_name, :for_family_name_kana, :for_first_name_kana, :postcode, :city, :city_number, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :region
end
