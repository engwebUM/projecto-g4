class AddAttachmentDocumentToExpenses < ActiveRecord::Migration
  def self.up
    change_table :expenses do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :expenses, :document
  end
end
