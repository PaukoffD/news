# == Schema Information
#
# Table name: tagoverlaps
#
#  id           :integer          not null, primary key
#  tag_id       :integer
#  name         :string
#  tagtarget_id :integer
#  nametarget   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class TagoverlapsControllerTest < ActionController::TestCase
  setup do
    @tagoverlap = tagoverlaps(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:tagoverlaps)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create tagoverlap' do
    assert_difference('Tagoverlap.count') do
      post :create, tagoverlap: { name: @tagoverlap.name, nametarget: @tagoverlap.nametarget, tag_id: @tagoverlap.tag_id, tagtarget_id: @tagoverlap.tagtarget_id }
    end

    assert_redirected_to tagoverlap_path(assigns(:tagoverlap))
  end

  test 'should show tagoverlap' do
    get :show, id: @tagoverlap
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @tagoverlap
    assert_response :success
  end

  test 'should update tagoverlap' do
    patch :update, id: @tagoverlap, tagoverlap: { name: @tagoverlap.name, nametarget: @tagoverlap.nametarget, tag_id: @tagoverlap.tag_id, tagtarget_id: @tagoverlap.tagtarget_id }
    assert_redirected_to tagoverlap_path(assigns(:tagoverlap))
  end

  test 'should destroy tagoverlap' do
    assert_difference('Tagoverlap.count', -1) do
      delete :destroy, id: @tagoverlap
    end

    assert_redirected_to tagoverlaps_path
  end
end
