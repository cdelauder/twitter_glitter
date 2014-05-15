class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.string :email
      # t.string :gravatar_id
      t.string :location
      t.string :oneliner
    end
  end
end
