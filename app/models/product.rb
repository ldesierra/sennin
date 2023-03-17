class Product < ApplicationRecord
  has_many :photos

  validates_presence_of :name, :description, :price, :stock

  accepts_nested_attributes_for :photos
end
