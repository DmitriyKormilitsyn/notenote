require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  test 'sign in, create movie and write a review' do
    post user_registration_path, params:
      { 'user[email]' => 'vasya@example.com',
        'user[password]' => '123456',
        'user[password_confirmation]' => '123456' }

    get '/notes/new', params: { 'notes[title]' => "123", 
    	'notes[content]' => 'content'}

    assert Note.where(user_id: @user_for_tests, title: "123")
  
  end
end
