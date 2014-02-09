class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :character, index: true

      t.timestamps
    end
  end
end
