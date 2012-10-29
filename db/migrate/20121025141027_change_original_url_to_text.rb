class ChangeOriginalUrlToText < ActiveRecord::Migration
  def up
    change_column :urls, :original_url, :text
  end

  def down
    change_column :urls, :original_url, :string
  end
end
