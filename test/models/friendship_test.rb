require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

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
    @user.save
    @user2.save
  end

  test "should be no friendship" do
    assert_nil @user.find_any_friendship_with(@user2)
  end

  test "user should invite user2" do
    assert @user.invite @user2
    assert_not Friendship.all.empty?
    assert @user.invited? @user2
    assert_not @user2.invited? @user
    assert_equal Friendship.first.status, "pending"
  end

  test "user2 should accept user" do
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
