class CreateDutyOptions < ActiveRecord::Migration
  def change
    create_table :duty_options do |t|
      t.integer :character_id
      t.integer :starting_size
      t.boolean :plus_five_xp
      t.boolean :plus_ten_xp
      t.boolean :plus_thousand_credits
      t.boolean :plus_two_thousand_five_hundred_credits

      t.timestamps
    end
  end
end
