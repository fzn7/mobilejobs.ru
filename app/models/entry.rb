require "html_generator"

class Entry < ActiveRecord::Base
  belongs_to :feed

  before_save do |entry|
    entry.description_html = HtmlGenerator.render entry.description
  end

  def self.update_from_feed(feed)
    feed_data = Feedjira::Feed.fetch_and_parse(feed.url)
    add_entries(feed_data.entries, feed)
  end

  private
  def self.add_entries(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => entry.id

      create!(
          :entry_id     => entry.id,
          :feed_id      => feed.id,
          :url          => entry.url,
          :title        => entry.title.sanitize,
          :description  => entry.summary.sanitize,
          :published_at => entry.published
      )

    end
  end
end
