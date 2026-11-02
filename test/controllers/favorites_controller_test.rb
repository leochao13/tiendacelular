require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @huawei= products(:huawei)

    @huawei_1= products(:huawei_1)

  end
  test "should return my favorites" do
    get favorites_url

    assert_response :success
  end

  test "should create favorite" do
    assert_difference('Favorite.count', 1) do
      post favorites_url(product_id: @huawei.id)
    end
    assert_redirected_to product_path(@huawei)
  end


   test "should unfavorite" do
    assert_difference('Favorite.count', -1) do
        delete favorite_url(@huawei_1.id)
    end

    assert_redirected_to product_path(@huawei_1)
  end
end
