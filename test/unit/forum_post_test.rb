require 'test_helper'

class ForumPostTest < ActiveSupport::TestCase
  setup do
   @fp = Factory.build :forum_post
  end

  test "standard validations" do
    no_post = Factory.build :forum_post, :post => ''
    assert no_post.invalid?, no_post.errors.to_s
  end
end
