class AddIndexForOriginalUrl < ActiveRecord::Migration
  def up
    add_index :urls, :original_url
  end

  def down
    remove_index :urls, :original_url
  end
end
