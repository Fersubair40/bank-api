class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.decimal :amount
      t.string :tran_type
      t.belongs_to :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
