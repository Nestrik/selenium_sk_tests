require_relative '../spec_helper.rb'
require_relative '../../pages/apress-companies_page/pages_edit'

describe 'Page edit' do

  before :all do
    @driver = start_browser
    @super_user_auth = Page::CONFIG['super_user_enter_url'].to_s
    @normal_user_auth = Page::CONFIG['normal_user_enter_url'].to_s
    @sk_page = Page::CONFIG['sk_page'].to_s
    @check_xpath = PagesEdit.new
  end

  after(:all) do
    @driver.quit
  end

  it 'check entry point with SU' do
    @driver.get @super_user_auth
    @driver.get @sk_page
    @setting_toolbar = @driver.find_element(:xpath, "//div[text()='Настройки']")
    @setting_toolbar.click
    @check_xpath.to_be(@driver, "//a[text()='Добавить новую страницу']", "toolbar")
    @check_xpath.to_be(@driver, "//a[text()='+ Добавить страницу']", "left menu")
  end

  it 'check entry point without SU' do
    @driver.get @normal_user_auth
    @driver.get @sk_page
    @check_xpath.not_to_be(@driver, "//div[text()='Настройки']", "Настройки")
    @check_xpath.not_to_be(@driver, "//a[text()='Добавить новую страницу']", "toolbar")
    @check_xpath.not_to_be(@driver, "//a[text()='+ Добавить страницу']", "left menu")
  end

end