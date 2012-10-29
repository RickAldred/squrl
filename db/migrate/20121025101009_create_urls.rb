class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :squeezed_url

      t.timestamps
    end

    add_index :urls, :squeezed_url
  end
end
