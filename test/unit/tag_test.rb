require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
   @tag = Factory.build :tag
  end

  test "standard validations" do
    long_name = Factory.build :tag, :name => 'this-tag-is-by-far-too-long'
    assert long_name.invalid?, long_name.errors.to_s

    short_name = Factory.build :tag, :name => 't'
    assert short_name.invalid?, short_name.errors.to_s

    no_name = Factory.build :tag, :name => ''
    assert no_name.invalid?, no_name.errors.to_s

    @tag.save!
    duplicate_name = Factory.build :tag, :name => @tag.name
    assert duplicate_name.invalid?, duplicate_name.errors.to_s

    bad_tag_with_symbol = Factory.build :tag, :name => 'bad_tag'
    assert bad_tag_with_symbol.invalid?, bad_tag_with_symbol.errors.to_s + " (tag had an underscore)"

    bad_tag_with_space = Factory.build :tag, :name => 'bad tag'
    assert bad_tag_with_space.invalid?, bad_tag_with_space.errors.to_s + " (tag had a space)"

    good_tag_with_everything = Factory.build :tag, :name => 'Tag-4'
    assert good_tag_with_everything.valid?, "caps, dashes and numbers are allowed"
  end
end
