require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  setup do
    @url = urls(:google)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post :create, url: { original_url: "http://www.abc.com/d/e/f" }
    end

    assert_redirected_to url_path(assigns(:url))
  end

  test "should not create url that already exists and show existing one instead" do
    assert_no_difference('Url.count') do
      post :create, url: { original_url: @url.original_url }
    end

    assert_redirected_to @url
    assert_equal flash[:notice], "URL has already been squeezed - see below"
  end

  test "should show url" do
    get :show, id: @url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url
    assert_response :success
  end

  test "should update url" do
    put :update, id: @url, url: { original_url: @url.original_url, squeezed_url: @url.squeezed_url }
    assert_redirected_to url_path(assigns(:url))
  end

  test "should destroy url" do
    assert_difference('Url.count', -1) do
      delete :destroy, id: @url
    end

    assert_redirected_to urls_path
  end

  test "should expand squeezed url and redirect to original url" do
    get :expand, squeezed_url: @url.squeezed_url
    assert_redirected_to @url.original_url
  end

  test "should not expand invalid squeezed url and redirect to index" do
    get :expand, squeezed_url: "wibble"
    assert_redirected_to index_url
    assert_equal flash[:notice], "Oops, that URL does not appear to be valid"
  end
end
