require "test/unit"
require_relative "../app/models/user.rb"


class UserTest < Test::Unit::TestCase

  def test_name
    user = User.new({"name" => "Pete"})
    assert_equal user.name, "Pete"
  end

  def test_email
    user = User.new({"email" => "pete@doximity.com"})
    assert_equal user.email, "pete@doximity.com"
  end

  def test_no_method
    user = User.new({"name" => "Pete"})
    user.blah
  end
end

