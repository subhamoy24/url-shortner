class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 254
      t.string :last_name, null: false, limit: 254
      t.string :email, null:false, index: { unique: true }, limit: 254
      t.string :password_digest, null: false
      t.boolean :admin, null: false, default: false
      t.string  :remember_digest
      t.timestamps
    end
  end
end
