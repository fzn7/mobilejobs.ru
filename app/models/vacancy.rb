require "token_generator"
require "html_generator"

require 'nokogiri'
require 'open-uri'

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
    if vacancy.description
      vacancy.excerpt_html     = HtmlGenerator.render Vacancy.extract_excerpt(vacancy.description)
      vacancy.description_html = HtmlGenerator.render vacancy.description
    end
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
    puts "Update from url #{feed.url}"
    eval "add_vacancies_#{feed.title} feed_data.entries, feed"
  end

  protected

  # Take the first three parts of text
  def self.extract_excerpt(text, divider = "\r\n\r\n")
    text.lines(divider).to_a.each(&:strip!).reject(&:blank?).take(3).join(divider)
  end

  private
  def self.add_vacancies_MoiKrug(entries, feed)
    entries.each do |entry|
      break if exists? :entry_id => "#{feed.id} #{entry.id}"

      skip_callback :create, :save

      begin
        doc = Nokogiri::HTML(open(entry.url))
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          break
        else
          raise e
        end
      end

      begin
        location = doc.at_css('span.location').text #address
      rescue Exception => error
        puts "location #{error} #{entry.url}"
      end

      #Закрыт доступ к отклику по email
      email = entry.url

      begin
        company_site = doc.at_css('div.company_site > a').attributes['href'].to_s
      rescue Exception => error
        puts "company_site #{error} #{entry.url}"
      end

      begin
        remote = doc.at_css('span.ready_to_remote').text #remote?
      rescue Exception => error
        puts "remote #{error} #{entry.url}"
      end

      begin
        descr = doc.css('div.vacancy_description').first.children.to_s
      rescue Exception => error
        puts "descr #{error} #{entry.url}"
      end

      v = Vacancy.new(
          :entry_id => "#{feed.id} #{entry.id}",
          :title => entry.title.sanitize,
          :description_html => descr,
          :company =>  entry.author,
          :url => company_site,
          :email => email,
          #:url => entry.url,
          #:name => '',
          :location => "#{location}#{remote}",
          :expire_at => entry.published + 2.weeks,
          :approved_at => entry.published,
          :created_at => entry.published,
          :admin_token => TokenGenerator.generate_token,
          :excerpt_html => HtmlGenerator.render(Vacancy.extract_excerpt(entry.summary)),
      )

      v.save(validate: false)
    end
  end
end
