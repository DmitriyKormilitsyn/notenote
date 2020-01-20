require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_index_url
    assert_response :success
  end
  test 'sign up' do
    post user_registration_path, params:
      { 'user[email]' => 'vasya@example.com',
        'user[password]' => '123456',
        'user[password_confirmation]' => '123456' }

    assert_redirected_to root_path


    assert User.find_by_email('vasya@example.com')
  end

  test 'fail sign up' do
    post user_registration_path, params:
      { 'user[email]' => 'vasya@example.com',
        'user[password]' => '123456',
        'user[password_confirmation]' => '123457' }

    assert_response :success # Controller didn't redirect to root_path
  end

  test 'sign in, create movie and write a review' do
    post user_registration_path, params:
      { 'user[email]' => 'vasya@example.com',
        'user[password]' => '123456',
        'user[password_confirmation]' => '123456' }

    get '/notes'
    assert_equal '/notes', path

    get '/notes/new'
    assert_equal '/notes/new', path
  end

  test "should create user and do and create basa" do
    get '/users/sign_up'
    assert_equal '/users/sign_up', path
    assert_difference('User.count') do
    post '/users' , user: { email: 'dima@example.com', password: "123456"}
    end 
  end

end
