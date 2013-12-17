class Location < ActiveRecord::Base

  has_many :restaurants

  def has_restaurants?
    active_restaurants.size != 0
  end

  def active_restaurants
    self.restaurants.where(:active => true)
  end
end
