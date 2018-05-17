require 'test_helper'

class SecretsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get secrets_edit_url
    assert_response :success
  end

  test "should get index" do
    get secrets_index_url
    assert_response :success
  end

  test "should get new" do
    get secrets_new_url
    assert_response :success
  end

  test "should get show" do
    get secrets_show_url
    assert_response :success
  end

  test "should get update" do
    get secrets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get secrets_destroy_url
    assert_response :success
  end

  test "should get create" do
    get secrets_create_url
    assert_response :success
  end

end
