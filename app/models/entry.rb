require "html_generator"

class Entry < ActiveRecord::Base
  belongs_to :feed


  scope :all_sorted, lambda { order('published_at DESC').all }

  def self.update_from_feed(feed)
    feed_data = Feedjira::Feed.fetch_and_parse(feed.url)
    eval "add_entries_#{feed.title} feed_data.entries, feed"
  end

  private
  def self.add_entries_FLru(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => entry.id

      create!(
          :entry_id     => entry.id,
          :feed_id      => feed.id,
          :url          => entry.url,
          :title        => entry.title.sanitize,
          :description  => entry.summary.sanitize,
          :published_at => entry.published,
          :description_html => HtmlGenerator.render(entry.summary.sanitize)
      )

    end
  end

  private
  def self.add_entries_Freelansim(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => entry.id

      create!(
          :entry_id     => entry.id,
          :feed_id      => feed.id,
          :url          => entry.url,
          :title        => entry.title.sanitize,
          :description  => entry.summary.sanitize,
          :published_at => entry.published,
          :description_html => entry.summary.sanitize
      )

    end
  end
end
