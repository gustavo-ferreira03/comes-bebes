class ChangeBirthdateToBeDatetimeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :birthdate, :datetime
  end
end
