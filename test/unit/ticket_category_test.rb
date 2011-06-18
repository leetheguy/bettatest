require 'test_helper'

class TicketCategoryTest < ActiveSupport::TestCase
  setup do
   @tc = Factory.build :ticket_category
  end

  test "standard validations" do
    long_name = Factory.build :ticket_category, :name => 'this is a really really totally stupid ridiculously long name for a ticket category that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    long_description = Factory.build :ticket_category, :description => 'This is a super duper extra stupid ridiculously long description that was designed with the exclusive and sole porpoise... (Is that how you spell purpose?) of quite simply and dramatically dwarfing the ticket category\'s name. And doing it once and for all. Never to be questioned. All your base are belong to us.'
    assert long_description.invalid?, long_description.errors.to_s

    no_name = Factory.build :ticket_category, :name => ''
    assert no_name.invalid?, no_name.errors.to_s
  end
end
