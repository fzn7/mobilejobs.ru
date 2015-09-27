class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url, required: true
      t.string :description

      t.timestamps null: false
    end
  end
end
