class GimmiePostsTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :poems do |t|
  		t.string :title
  		t.string :poem
  		t.integer :user_id
  	end
  end
end
