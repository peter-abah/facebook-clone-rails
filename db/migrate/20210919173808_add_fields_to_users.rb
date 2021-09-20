class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.rename :name, :first_name
      t.string :last_name, default: ''
      t.string :current_city, default: ''
      t.text :bio, default: ''
      t.datetime :birthday
    end
  end
end
