class AddAttachmentDocumentToRevenues < ActiveRecord::Migration
  def self.up
    change_table :revenues do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :revenues, :document
  end
end
