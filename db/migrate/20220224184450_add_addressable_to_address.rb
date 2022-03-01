class AddAddressableToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :addressable, polymorphic: true, null: false
  end
end
