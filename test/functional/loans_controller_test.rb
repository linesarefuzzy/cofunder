require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post :create, :loan => { :Amount => @loan.Amount, :Nivel => @loan.Nivel, :Rate => @loan.Rate }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should show loan" do
    get :show, :id => @loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @loan
    assert_response :success
  end

  test "should update loan" do
    put :update, :id => @loan, :loan => { :Amount => @loan.Amount, :Nivel => @loan.Nivel, :Rate => @loan.Rate }
    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete :destroy, :id => @loan
    end

    assert_redirected_to loans_path
  end
end
