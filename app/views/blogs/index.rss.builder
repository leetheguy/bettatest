xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@blog.beta_test.name} bettatest blog"
    xml.description "This is the blog for #{@blog.beta_test.name} hosted at bettatest.com"
    xml.link formatted_blogs_url(:rss)
    
    for blog in @blogs
      xml.item do
        xml.title blog.name
        xml.description blog.post
        xml.pubDate blog.created_at.to_s(:rfc822)
        xml.link formatted_blog_url(blog, :rss)
        xml.guid formatted_blog_url(blog, :rss)
      end
    end
  end
end
