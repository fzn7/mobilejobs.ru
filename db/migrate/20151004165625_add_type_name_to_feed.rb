class AddTypeNameToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :data_type, :integer
    add_column :feeds, :name, :string
  end
end
