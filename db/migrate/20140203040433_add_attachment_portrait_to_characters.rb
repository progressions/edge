class AddAttachmentPortraitToCharacters < ActiveRecord::Migration
  def self.up
    change_table :characters do |t|
      t.attachment :portrait
    end
  end

  def self.down
    drop_attached_file :characters, :portrait
  end
end
