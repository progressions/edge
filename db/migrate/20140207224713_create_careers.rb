class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :key
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
