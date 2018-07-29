require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
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

  test "should send notification when a friend request is sent" do
    assert @user2.notifications.empty?
    @user.invite @user2
    assert_not @user2.notifications.empty?
    assert_not @user2.notifications.unread.empty?
    @user2.accept @user
    assert @user2.notifications.unread.empty?
    assert_not @user2.notifications.empty?
  end
end
