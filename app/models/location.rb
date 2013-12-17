class Location < ActiveRecord::Base

  has_many :restaurants

  def has_restaurants?
    self.restaurants.where(:active => true).size != 0
  end
end
