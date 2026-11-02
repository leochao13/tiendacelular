require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
  end

  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 0
    assert_select '.category', 13
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:huawei).id)
    assert_response :success
    assert_select '.product', 0
  end

  test 'render a list of products filtered by min_price and max_price' do
    get products_path(min_price: 2000, max_price: 3000)

    assert_response :success
    assert_select '.product', 0
    assert_select 'h2', 'zte axon 50lite'
  end


  test 'sort products by expensive prices first' do
    get products_path(order_by: 'expensive')

    assert_response :success
    assert_select '.product', 0
    assert_select '.products .product:first-child h2', 'razer 40 ultra'
  end


  test 'sort products by cheapest prices first' do
    get products_path(order_by: 'cheapest')

    assert_response :success
    assert_select '.product', 0
    assert_select '.products .product:first-child h2', 'zte axon 50lite'
  end


  test 'render a detailed product page' do
    get product_path(products(:huawei))
    assert_response :success
    assert_select '.title', 'huawei P30'
    assert_select '.description', 'Lite'
    assert_select '.price', '$3949'
  end
  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
end
 test 'allow to create a new product' do
  post products_path, params: {
      product: {
        title: 'huawei',
        description: 'Nova 11i',
        price: 3000,
        category_id: categories(:huawei).id
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
  end

 test 'does not allow to create a new product with empty fields' do
  post products_path, params: {
  product: {
    title: '',
    description: '5G',
    price: '400'
  }
  }
   assert_response :unprocessable_entity
  end

  test 'render a edit product form' do
    get edit_product_path(products(:huawei))
    assert_response :success
    assert_select 'form'
end
test 'allow to update a product' do
  patch product_path(products(:huawei)), params: {
  product: {
    price: 120
  }
  }
   assert_redirected_to products_path
   assert_equal flash[:notice], 'Tu producto se ha actualizado correctamente'
 end

 test 'does not allow to update a product with an invalid field' do
  patch product_path(products(:huawei)), params: {
  product: {
    price: nil
  }
  }
assert_response :unprocessable_entity
end
test 'can delete products' do
  assert_difference('Product.count', -1) do
    delete product_path(products(:huawei))
  end
  assert_redirected_to products_path
  assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
end
end
