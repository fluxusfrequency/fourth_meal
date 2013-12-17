class ItemCategory < ActiveRecord::Base
  validates_presence_of :item_id
  validates_presence_of :category_id
  validates_numericality_of :item_id
  validates_numericality_of :category_id

  belongs_to :category
  belongs_to :item
end
