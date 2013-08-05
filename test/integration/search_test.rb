require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "search for item in database works" do
    visit root_path
    Link.create(title: "The Internet's homepage", url: "http://reddit.com")

    assert page.has_button?("Search")
    fill_in 'q', with: "internet"
    click_button("Search")

    link = Link.last
    assert page.has_content?(link.title)
    assert page.has_link?(link.title, href: link.url), "The url is missing"
  end
end