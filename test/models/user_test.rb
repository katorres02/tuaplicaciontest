require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(name: 'John', email: 'john@example.com', password: '12345678')
    assert user.valid?
  end

  test 'invalid without name' do
    user = User.new(email: 'john@example.com', password: '12345678')
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:name]
  end

  test 'invalid without email' do
    user = User.new(name: 'John', password: '12345678')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
end
