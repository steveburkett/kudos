class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :kudos_given_count
      t.integer :kudos_received_count

      t.timestamps
    end
  end
end
