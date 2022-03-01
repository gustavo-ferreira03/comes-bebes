class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password
      t.date :birthdate
      t.string :cpf
      t.integer :user_type

      t.timestamps
    end
  end
end
