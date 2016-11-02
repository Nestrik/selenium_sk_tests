require_relative '../spec_helper.rb'
require_relative '../../pages/apress-companies_page/pages_edit'

describe 'Page edit' do

  let(:user_auth_admin) { Page::CONFIG['super_user_enter_url'].to_s }
  let(:user_auth_without_sk) { Page::CONFIG['normal_user_enter_url'].to_s }
  let(:sk_page) { Page::CONFIG['sk_page'].to_s }
  let(:check_xpath) { PagesEdit.new }
  let(:setting_toolbar) { @driver.find_element(:xpath, "//div[text()='Настройки']") }

  before :context do
    @driver = start_browser
  end

  after :context do
    @driver.quit
  end

  context 'Check exist of entry point while role SU' do

    before{
      @driver.get user_auth_admin
      @driver.get sk_page
    }

    it 'in setting' do
      setting_toolbar.click
      expect(@driver.find_element(:xpath, "//a[text()='Добавить новую страницу']").displayed?).to be true
    end

    it 'in left menu' do
      expect(@driver.find_element(:xpath, "//a[text()='+ Добавить страницу']").displayed?).to be true
    end

  end

  context 'Check exist of entry point while role authorized user without sk' do

    before{
      @driver.get user_auth_without_sk
      @driver.get sk_page
    }

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
  end

end