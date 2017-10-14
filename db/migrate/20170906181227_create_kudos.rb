class CreateKudos < ActiveRecord::Migration[5.1]
  def change
    create_table :kudos do |t|
      t.integer :giver_id
      t.integer :receiver_id
      t.string :text

      t.timestamps
    end

    add_index :kudos, :giver_id
    add_index :kudos, :receiver_id
  end
end
