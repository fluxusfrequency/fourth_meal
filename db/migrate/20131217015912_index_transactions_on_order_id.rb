class IndexTransactionsOnOrderId < ActiveRecord::Migration
  def change
    add_index :transactions, :order_id
  end
end
