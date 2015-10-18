class AddEntryIdToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :entry_id, :string
  end
end
