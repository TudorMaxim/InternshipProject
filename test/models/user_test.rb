require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new( first_name: "Tudor",
                      last_name: "Maxim",
                      email: "tudor.maxim@takeofflabs.com",
                      password: "password",
                      password_confirmation: "password",
                      confirmed_at: Time.now)


    @user2 = User.new(  first_name: "Mike",
                        last_name: "Jonson",
                        email: "mike.jonson@example.com",
                        password: "password",
                        password_confirmation: "password",
                        confirmed_at: Time.now)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first_name should be present" do
    @user.first_name = "   "
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@example..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end


  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "full name test" do
    assert_equal @user.full_name , "Tudor Maxim"
  end

  test "should be no friendship" do
    assert_nil @user.find_any_friendship_with(@user2)
  end

  test "user should invite user2" do
    @user.save
    @user2.save
    assert @user.invite @user2
    assert_not Friendship.all.empty?
    assert @user.invited? @user2
    assert_not @user2.invited? @user
    assert_equal Friendship.first.status, "pending"
  end

  test "user2 should accept user" do
    @user.save
    @user2.save
    assert @user.invite @user2
    assert_not Friendship.all.empty?
    assert_not @user.accept @user2
    assert @user2.accept @user
    assert_equal @user.friends_number, 1
    assert_equal @user2.friends_number, 1
    assert_equal Friendship.first.status, "accepted"
    assert_equal @user.friends, [@user2]
    assert_equal @user2.friends, [@user]
    assert @user.friend_with? @user2
    assert @user2.friend_with? @user
  end

  test "user should unfriend user2" do
    @user.save
    @user2.save
    assert @user.invite @user2
    assert_not Friendship.all.empty?
    assert_not @user.accept @user2
    assert @user2.accept @user
    @user.unfriend @user2
    assert Friendship.all.empty?
    assert_not @user.friend_with? @user2
    assert_not @user2.friend_with? @user
  end
end
