# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://mobilejobs.ru"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  Vacancy.find_each do |vacancy|
    add vacancy_path(vacancy), :lastmod => vacancy.updated_at, :priority => 0.7, :changefreq => 'never'
  end

  Page.ids.each do |page|
    add "/pages/#{page}", :priority => 0.5, :changefreq => 'never'
  end
end
