class Product < ApplicationRecord
  # belongs_to :user, optional: true
  # has_many :categories, optional: true 
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :region
  belongs_to_active_hash :day

  validates :name, presence: true, length: { maximum: 40 }
  validates :item_info, presence: true
  validates :price, presence: true

  validates_associated :images
  validates :images, presence: true
end
