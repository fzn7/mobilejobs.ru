class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :feed_id
      t.string :title
      t.string :link
      t.string :description
      t.datetime :published_at
      t.belongs_to :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
