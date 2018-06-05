class GimmieUsersAndPoems < ActiveRecord::Migration[5.2]
  def change
  	create_table :users_and_poems do |t|
  		t.integer :user_id
  		t.integer :poem_id  		
  	end
  end
end
