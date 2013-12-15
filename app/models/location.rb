class Location < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  has_many :restaurants
end
