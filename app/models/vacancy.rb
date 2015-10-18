require "token_generator"
require "html_generator"

class Vacancy < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :location, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :unless => Proc.new { |vacancy| vacancy.email.blank? } }
  validates :expire_at, :presence => true

  before_create do |vacancy|
    vacancy.owner_token = TokenGenerator.generate_token
    vacancy.admin_token = TokenGenerator.generate_token
  end

  before_save do |vacancy|
    vacancy.excerpt_html     = HtmlGenerator.render extract_excerpt(vacancy.description)
    vacancy.description_html = HtmlGenerator.render vacancy.description
  end

  scope :approved, lambda { where("approved_at IS NOT NULL") }
  scope :not_approved, lambda { where({ :approved_at => nil }) }
  scope :not_outdated, lambda { |date| where("expire_at >= ?", date) }
  scope :descent_order, lambda { order("id DESC") }
  scope :available, lambda { approved.not_outdated(Date.current).descent_order }

  def approved?
    self.approved_at.present?
  end

  def approve!
    self.approved_at = Time.now and self.save!
  end

  def expired?
    self.expire_at.past?
  end

  def self.update_from_feed(feed)
    feed_data = Feedjira::Feed.fetch_and_parse(feed.url)
    eval "add_vacancies_#{feed.title} feed_data.entries, feed"
  end

  protected

  # Take the first three parts of text
  def extract_excerpt(text, divider = "\r\n\r\n")
    text.lines(divider).to_a.each(&:strip!).reject(&:blank?).take(3).join(divider)
  end

  private
  def self.add_vacancies_MoiKrug(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => "#{feed.id} #{entry.id}"

      skip_callback :create, :save

      v = Vacancy.new(
                      :entry_id => "#{feed.id} #{entry.id}",
                      :title => entry.title.sanitize,
                      :description => entry.summary,
                      :company =>  entry.author,
                      #:url => entry.url,
                      #:name => '',
                      :location => 'Undefined',
                      :expire_at => entry.published + 2.weeks,
                      :approved_at => entry.published,
                      :created_at => entry.published,
                      :admin_token => TokenGenerator.generate_token,
                      :excerpt_html => HtmlGenerator.render(entry.summary),
                      )
      v.save(validate: false)
    end
  end
end
