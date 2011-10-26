atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated
  feed.author.name @author

  if @blogs.count > 0
    @blogs.each do |blog|
      next if blog.updated_at.blank?

      feed.entry( blog ) do |entry|
        entry.title blog.name
        entry.link blogs_url(:beta_test_id => blog.beta_test.id)
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
