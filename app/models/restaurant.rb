class Restaurant < ActiveRecord::Base
  has_many :categories
  has_many :items
  has_many :orders
  has_many :restaurant_users

  validates :name, presence: true
  validates :description, presence: true
  validates_inclusion_of :status, :in => ["pending", "rejected", "approved"]
  validates_inclusion_of :theme,
    :in => ["application", "dark", "light", "solarized"]

  belongs_to :location, :touch => true

  def to_param
    @param ||= slug || name.parameterize
  end

  def generate_slug
    self.update(slug: name.parameterize)
  end

  def self.find_by_slug(target)
    where(slug: target).first
  end

  def find_owner
    owners.last
  end

  def owners
    Rails.cache.fetch("#{id}s_owners") do
      self.restaurant_users.where(role: "owner").collect do |ru|
        ru.user
      end
    end
  end

  def employees
    Rails.cache.fetch("#{id}s_employees") do
      self.restaurant_users.where(role: "employee").collect do |ru|
        ru.user
      end
    end
  end

  def is_owner?(user)
    owners.include?(user)
  end

  def is_employee?(user)
    employees.include?(user)
  end

  def active?
    self.active
  end

  def inactive?
    self.active == false
  end

  def offline?
    self.approved? && self.inactive?
  end

  def activate
    self.update(active: true)
  end

  def deactivate
    self.update(active: false)
  end

  def toggle_status
    self.active? ? deactivate : activate
  end

  def <=> (other)
    self.id <=> other.id
  end

  def approve
    self.update(status: 'approved')
  end

  def approved?
    self.status == "approved"
  end

  def unapproved?
    self.approved? == false
  end

  def reject
    self.update(status: 'rejected')
  end

  def rejected?
    self.status == "rejected"
  end

  def pending?
    self.status == "pending"
  end

  def categories_with_items
    Rails.cache.fetch("#{id}s_categories_with_items") do
      self.categories.reject {|c| c.items.size == 0 }
    end
  end

  def self.themes
    %w(application dark light solarized)
  end

  def create_owner(user)
    self.restaurant_users.create( :restaurant => self,
                                  :user => user,
                                  :role => "owner")
  end

end
