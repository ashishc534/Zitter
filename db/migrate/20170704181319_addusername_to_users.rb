class AddusernameToUsers < ActiveRecord::Migration
  def change
  	add_column :users , :username , :string
  	add_index :users , :username , unique: true #For Fast Lookup
  end
end
