require_relative '../spec_helper.rb'
require_relative '../../project_inject/pages/create_company_auth_page'


describe 'menus edit page' do


  before :context do
    @driver = start_browser
    @portal_page = Page::CONFIG['portal_page'].to_s
    @driver.get(Page::CONFIG['normal_user_enter_url'].to_s) # авторизуемся под обычным пользователем
    create_company_page = CreateCompanyPage.new(@driver, true)
    create_company_page.create_company # создаем компанию под обычным пользователем
    @company_id = create_company_page.get_id_current_company @driver.current_url.to_s
    @driver.get(@portal_page + '/firms/' + @company_id)
    sleep 0.5
    @driver.action.send_keys(:escape).perform # Этот костыль нужен, что бы закрыть попапы
  end

  after :context do

    @driver.quit
  end

  context '' do
    it 'Edit link in vertical menu should be visible' do
      exist_of_element = @driver.find_element(:xpath, "//a[contains(.,'Редактировать меню')]").displayed?
      expect(exist_of_element).to be true
    end

    it 'Edit link in horizontal menu should be visible' do
      exist_of_element = @driver.find_element(:xpath, "//a[contains(.,'Редактировать меню')]").displayed?
      expect(exist_of_element).to be true
    end

    it 'Edit link in toolbar menu should be visible when opened Settings tab' do
      @driver.find_element(:xpath, "//div[@class='toolbar-body']/ul/li/div[text()='Настройки']").click
      exist_of_element = (@driver.find_element(:xpath, "//a[contains(.,'Редактировать меню')]")).displayed?
      expect(exist_of_element).to be true
    end

    it 'element at active tab should be visible' do
    end
  end
end