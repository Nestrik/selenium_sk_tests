require_relative '../spec_helper.rb'

describe 'menus edit page' do

  before :all do
    @driver = start_browser
    @portal_page = Page::CONFIG['portal_page'].to_s
  end

  after(:all) do
    @driver.quit
  end

  it 'base elements should be visible' do
    @driver.get @portal_page
  end

  it 'element at active tab should be visible' do
    @driver.get(@portal_page + '/gde_kupit_stroymaterialy')
  end
end