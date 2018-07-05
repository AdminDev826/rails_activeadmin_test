require 'test_helper'
require 'generators/my_base/my_base_generator'

class MyBaseGeneratorTest < Rails::Generators::TestCase
  tests MyBaseGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
