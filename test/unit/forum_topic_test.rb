require 'test_helper'

class ForumTopicTest < ActiveSupport::TestCase
  setup do
   @ft = Factory.build :forum_topic
  end

  test "standard validations" do
    long_name = Factory.build :forum_topic, :name => 'this is a really really totally stupid ridiculously long name for a forum category that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    long_description = Factory.build :forum_topic, :description => 'This is a super duper extra stupid ridiculously long description that was designed with the exclusive and sole porpoise... (Is that how you spell purpose?) of quite simply and dramatically dwarfing the forum category\'s name. And doing it once and for all. Never to be questioned. All your base are belong to us.'
    assert long_description.invalid?, long_description.errors.to_s

    no_name = Factory.build :forum_topic, :name => ''
    assert no_name.invalid?, no_name.errors.to_s
  end
end
