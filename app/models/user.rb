class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, presence: true
  validates :name, :email, uniqueness: true
  has_one :address
  has_many :products

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :region
end
