require_relative '../../spec/spec_helper'

class CreateCompanyPage
  include PageObject
  page_url(Page::CONFIG['create_company_url'].to_s)

  # Описание страницы
  text_field(:tel_code, xpath: '//input[@name=\'address[phones_attributes][0][code]\']')
  text_field(:tel_number, xpath: '//input[@name=\'address[phones_attributes][0][number]\']')
  text_field(:company_name, id: 'company_name')
  text_field(:company_announce, xpath: '//input[@id=\'apress_company_abouts_company_about_announce\']')
  select(:country, id: 'country_id_')
  select(:province, id: 'province_id_')
  select(:city, id: 'city_id_')
  button(:submit, xpath: '//input[@type=\'submit\']')


  # Create company while role Owner
  def create_company
    self.company_name = 'Auto test company ' + Random.rand(100..999).to_s
    self.tel_code = Random.rand(10000..99999).to_s
    self.tel_number = Random.rand(10000..99999).to_s
    self.country = 'Россия'
    self.province = 'Свердловская'
    self.city = 'Екатеринбург'
    self.company_announce = 'test'
    self.submit
  end

  # Возвращает id новой компании (из урла), страница выбора дизайна (при создании) которой открыта
  def get_id_current_company (url)
    url.split('?').last.split('=').last
  end
end