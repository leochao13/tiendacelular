# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  test "should render an empty category" do
    assert_equal(
      %(<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-gray-300\" href=\"/\">Cualquiera</a>\n),
      render_inline(CategoryComponent.new).to_html
    )
  end

  test "should render a category" do
    category = Category.last
    assert_equal(
      %(<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-white\" href=\"/?category_id=961394336\">razer</a>\n),
      render_inline(CategoryComponent.new(category: category)).to_html
    )
  end
end
