xml.instruct! :xml, :version => '1.0'
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc 'http://bettatest.com'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/overview'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/game'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/developer'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/company'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/subscription'
    xml.changefreq 'monthly'
  end
  xml.url do
    xml.loc 'http://bettatest.com/beta_tests/?all=true'
    xml.changefreq 'daily'
  end
  @beta_tests.each do |bt|
    xml.url do
      xml.loc        beta_test_url(bt)
      xml.changefreq 'daily'
      xml.lastmod    bt.updated_at.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.priority   '0.8'
    end
  end
end
