class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin
      t.string :avatar

      t.timestamps null: false
    end
  end
end
