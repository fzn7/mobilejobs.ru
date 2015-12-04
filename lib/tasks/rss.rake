task :update_data => :environment  do
  puts "-------------------- update start #{Time.now.strftime("%d/%m/%Y %H:%M")}"
  Feed.where(:data_type => 0).each do |feed|
    Entry.update_from_feed(feed)
  end

  v_count = Vacancy.count

  Feed.where(:data_type => 1).each do |feed|
    Vacancy.update_from_feed(feed)
  end

  puts "-------------------- Vacancy update complete #{Time.now.strftime("%d/%m/%Y %H:%M")} old:#{v_count} new: #{Vacancy.count}"
end