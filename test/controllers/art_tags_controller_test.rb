require 'test_helper'

class ArtTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get art_tags_index_url
    assert_response :success
  end

  test "should get new" do
    get art_tags_new_url
    assert_response :success
  end

  test "should get create" do
    get art_tags_create_url
    assert_response :success
  end

  test "should get show" do
    get art_tags_show_url
    assert_response :success
  end

  test "should get update" do
    get art_tags_update_url
    assert_response :success
  end

  test "should get destroy" do
    get art_tags_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get art_tags_edit_url
    assert_response :success
  end

end
