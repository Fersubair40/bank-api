class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_digest, null: false
      t.string :fullname, null: false

      t.timestamps
    end
  end
end
