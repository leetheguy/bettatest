require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  setup do
    @blog = Factory.build :blog
  end
  
  test "validations" do
    long_name = Factory.build :blog, :name => 'this is a really really totally stupid ridiculously long name for a blog that no one will ever remember and again, this is a really really totally stupid ridiculously long name for a blog that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    no_name = Factory.build :blog, :name => ''
    assert no_name.invalid?, no_name.errors.to_s

    no_post = Factory.build :blog, :post => ''
    assert no_post.invalid?, no_post.errors.to_s
  end
end
