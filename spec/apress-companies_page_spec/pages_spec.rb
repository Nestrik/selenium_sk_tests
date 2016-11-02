require_relative '../spec_helper.rb'
require_relative '../../pages/apress-companies_page/pages_edit'

describe 'Page edit' do

  let(:user_auth_admin) { Page::CONFIG['super_user_enter_url'].to_s }
  let(:user_auth_without_sk) { Page::CONFIG['normal_user_enter_url'].to_s }
  let(:sk_page) { Page::CONFIG['sk_page'].to_s }

  before :context do
    @driver = start_browser
  end

  after :context do
    @driver.quit
  end

  context 'Check exist of entry point while role SU' do

    before do
      @driver.get user_auth_admin
      @driver.get sk_page
      @driver.action.send_keys(:escape).perform
    end

    it 'in setting' do
      @driver.find_element(:xpath, "//div[text()='Настройки']").click
      expect(@driver.find_element(:xpath, "//a[text()='Добавить новую страницу']").displayed?).to be true
    end

    it 'in left menu' do
      expect(@driver.find_element(:xpath, "//a[text()='+ Добавить страницу']").displayed?).to be true
    end

  end

  context 'Check exist of entry point while role authorized user without sk' do

    before do
      @driver.get user_auth_without_sk
      @driver.get sk_page
    end

    it 'button setting' do
      expect(@driver.find_element(:xpath, "div[text()='Настройки']")).to be nil
    end

    it 'in setting' do
      expect(@driver.find_element(:xpath, "//a[text()='Добавить новую страницу']")).to be nil
    end

    it 'in left menu' do
      expect(@driver.find_element(:xpath, "//a[text()='+ Добавить страницу']")).to be nil
    end

  end

  it 'check HTML elements' do
    @driver.get user_auth_admin
    @driver.get sk_page+"pages/new"

    #TODO проверки title, header и т.д.
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