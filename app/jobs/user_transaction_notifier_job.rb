class UserTransactionNotifierJob
  @queue = :emails

  def self.perform(data)
    TransactionNotifier.user_email(data).deliver
  end
end