class CreateUsers < ActiveRecord::Migration[5.2]
  def change
  	create_table :users do |t|
  		t.string :first_name
  		t.string :last_name
  		t.integer :password #look up secure?
  		t.string :email
  		t.date :birth_date
  	end
    end
end