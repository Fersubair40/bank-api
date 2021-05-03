class ChangeBalanceToBeDecimalInAccount < ActiveRecord::Migration[6.1]
  def change
    change_column :accounts, :balance, :decimal
  end
end
