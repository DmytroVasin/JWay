xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
      xml.loc("http://rails-junior.com")
      xml.changefreq("daily")
      xml.priority(1.0)
  end

  @posts.each do |post|
    xml.url do
      xml.loc(post_url(post.url_link))
      xml.lastmod post.updated_at.to_date
      xml.changefreq("daily")
      xml.priority(0.9)
    end
  end
end
