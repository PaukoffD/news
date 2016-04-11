# == Schema Information
#
# Table name: tagexcepts
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TagexceptsControllerTest < ActionController::TestCase
  setup do
    @tagexcept = tagexcepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tagexcepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tagexcept" do
    assert_difference('Tagexcept.count') do
      post :create, tagexcept: { name: @tagexcept.name, tag_id: @tagexcept.tag_id }
    end

    assert_redirected_to tagexcept_path(assigns(:tagexcept))
  end

  test "should show tagexcept" do
    get :show, id: @tagexcept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tagexcept
    assert_response :success
  end

  test "should update tagexcept" do
    patch :update, id: @tagexcept, tagexcept: { name: @tagexcept.name, tag_id: @tagexcept.tag_id }
    assert_redirected_to tagexcept_path(assigns(:tagexcept))
  end

  test "should destroy tagexcept" do
    assert_difference('Tagexcept.count', -1) do
      delete :destroy, id: @tagexcept
    end

    assert_redirected_to tagexcepts_path
  end
end
