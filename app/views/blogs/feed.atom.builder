atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  if @blogs.count > 0
    @blogs.each do |blog|
      next if blog.updated_at.blank?

      feed.entry( blog ) do |entry|
        entry.url blogs_url(:beta_test_id => blog.beta_test.id)
        entry.title blog.name
        entry.content markdown(blog.post), :type => 'html'

        # the strftime is needed to work with Google Reader.
        entry.updated(blog.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

        entry.author do |author|
          author.name (blog.beta_test.name)
        end
      end
    end
  end
end
