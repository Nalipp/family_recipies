require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Arther Bugsby", email: "arther_bugsby@gmail.com")
  end

  test "chefname must be valid" do
    assert @chef.valid?
  end

  test "chefname must be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname must not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "chefname must not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email must not be too long" do
    @chef.email = "a" * 106
    assert_not @chef.valid?
  end

  test "email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invliad addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. ee@t_am_.com foo@ee+aar.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end

end
