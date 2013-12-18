class OwnerRejectJob
  @queue = :emails

  def self.perform(owner_email, link, restaurant_name, restaurant_description)
    OwnerNotifier.owner_reject_email(owner_email, link, restaurant_name, restaurant_description).deliver
  end
end