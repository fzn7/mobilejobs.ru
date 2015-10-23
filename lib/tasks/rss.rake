task :update_data => :environment  do
  Feed.where(:data_type => 0).each do |feed|
    Entry.update_from_feed(feed)
  end

  Feed.where(:data_type => 1).each do |feed|
    Vacancy.update_from_feed(feed)
end
end