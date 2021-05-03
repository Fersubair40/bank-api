class ChangeAccountNrInUsersToBigint < ActiveRecord::Migration[6.1]
  def change
    change_column :accounts, :account_nr, :bigint
  end
end
