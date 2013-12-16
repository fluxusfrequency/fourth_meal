class Category < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :restaurant
  has_many :item_categories
  has_many :items, through: :item_categories

  def to_param
    @param ||= title.downcase.gsub(" ", "_")
  end

  def self.find_by_slug(target)
    where(slug: target).first
  end

end
