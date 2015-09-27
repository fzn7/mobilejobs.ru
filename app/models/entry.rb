class Entry < ActiveRecord::Base
  belongs_to :feed

  attr_accessible :title, :link, :description, :published_at

  def self.update_from_feed(feed)
    feed_data = Feedjira::Feed.fetch_and_parse(feed.url)
    add_entries(feed_data.entries, feed)
  end

  private
  def self.add_entries(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => entry.id

      create!(
          :feed_id      => feed.id,
          :url          => entry.url,
          :title        => entry.title.sanitize,
          :summary      => entry.summary.sanitize,
          :published_at => entry.published
      )

    end
  end
end
