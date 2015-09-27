class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :entry_id, index: true
      t.string :feed_id
      t.string :title
      t.string :url
      t.text :description
      t.text :description_html
      t.datetime :published_at
      t.belongs_to :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
