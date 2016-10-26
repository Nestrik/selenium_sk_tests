class MenusEditPage
  include PageObject
  #BLIZKO
  page_url('http://test.test3-blizko.ru/settings')

  # Блок с текстовой зоной
  paragraph(:textZoneText, :xpath => '//p[contains(.,\'Текстовая зона CompaniesMenus/MenuEditForm\')]')

  # Вкладки
  link(:tabHorizontalMenu, :xpath => '//a[@href=\'#horizontal-menu\']')
  link(:tabVerticalMenu, :xpath => '//a[@href=\'#vertical-menu\']')
  link(:tabCustomizationMenu, :xpath => '//a[@href=\'#customization-settings\']')

  # Горизонтальное меню: заголовки колонок
  div(:tableHorizontalMenuHeaderHorizontalLabels1, :xpath => '//*[@id=\'horizontal-menu\']/div[@class=\'grid-row header\']/div[1]')
  div(:tableHorizontalMenuHeaderHorizontalLabels2, :xpath => '//*[@id=\'horizontal-menu\']/div[@class=\'grid-row header\']/div[2]')
  div(:tableHorizontalMenuHeaderHorizontalLabels3, :xpath => '//*[@id=\'horizontal-menu\']/div[@class=\'grid-row header\']/div[3]')
  # Вертикальное меню: заголовки колонок
  div(:tableVerticalMenuHeaderLabels1, :xpath => '//*[@id=\'vertical-menu\']/div[@class=\'grid-row header\']/div[1]')
  div(:tableVerticalMenuHeaderLabels2, :xpath => '//*[@id=\'vertical-menu\']/div[@class=\'grid-row header\']/div[2]')
  div(:tableVerticalMenuHeaderLabels3, :xpath => '//*[@id=\'vertical-menu\']/div[@class=\'grid-row header\']/div[3]')
  # Страница кастомизации: заголовки колонок
  div(:tableCustomizationSettingHeaderLabels1, :xpath => '//*[@id=\'customization-settings\']/div[@class=\'grid-row header\']/div[1]')
  div(:tableCustomizationSettingsHeaderLabels2, :xpath => '//*[@id=\'customization-settings\']/div[@class=\'grid-row header\']/div[2]')
  div(:tableCustomizationSettingsHeaderLabels3, :xpath => '//*[@id=\'customization-settings\']/div[@class=\'grid-row header\']/div[3]')
  div(:tableQTip, :xpath => '//div[@class=\'qtip-icon js-qtip-icon\']') # Иконка подсказки в колонке "Title"

  # Элемент раздела Горизонтальное меню

  # Элемент раздела Вертикальное меню

  # Элемент раздела Кастомизации

end