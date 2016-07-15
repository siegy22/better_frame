require 'test_helper'

class IncludeTest < ActionDispatch::IntegrationTest
  test "include & navigate site with better_frame" do
    visit '/foreign_website'
    wait_for_page_load("products#index")

    assert_equal '/', find("#rails-path")["data-path"]

    click_on "New Product"
    wait_for_page_load("products#new")

    history(:back)
    wait_for_page_load("products#index")

    assert_equal 2, all("table tbody tr").count

    history(:forward)
    wait_for_page_load("products#new")

    assert_equal '/products/new', find("#rails-path")["data-path"]

    fill_in "Name", with: "test"
    fill_in "Price", with: "120.30"
    find("#submit-product").click

    wait_for_page_load("products#show")

    assert_equal "Name: test", find("#name").text
    assert_equal "Price: 120.3", find("#price").text

    click_on "Back"
    wait_for_page_load("products#index")

    assert_equal 3, all("table tbody tr").count
  end

  def wait_for_page_load(id)
    converted_id_selector = "#" + id.gsub("#", "-")
    find(converted_id_selector)
  end

  def history(whereto)
    page.execute_script "window.history.#{whereto}()"
  end
end
