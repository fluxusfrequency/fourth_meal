class OwnerApproveJob
  @queue = :emails

  def self.perform(owner_email, link, restaurant_name, restaurant_description)
    OwnerNotifier.owner_approve_email(owner_email, link, restaurant_name, restaurant_description).deliver
  end
end