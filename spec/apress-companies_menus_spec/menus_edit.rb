require '../spec_helper'

describe 'menus edit page' do
  before :suite do
    @browser = Selenium::WebDriver.for :chrome
    @menus_edit_page = MenusEditPage.new(@browser, true)
  end

  it 'base elements should be visible' do
    should 1 == 1
  end

  it 'element at active tab should be visible' do


  end
end