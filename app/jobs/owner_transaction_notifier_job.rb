class OwnerTransactionNotifierJob
  @queue = :emails

  def self.perform(data)
    TransactionNotifier.owner_email(data).deliver
  end
end