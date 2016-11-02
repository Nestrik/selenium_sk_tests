class PagesEdit
  #include PageObject # Без комментирования это строки код не работает

  def to_be(driver,xpath,where)

    if driver.find_element(:xpath, xpath) == nil
      raise 'My Exception'
    else
      puts '  check in '+where+' ok'
    end

  end

  def not_to_be(driver,xpath,where)

    if driver.find_element(:xpath, xpath) == nil
      puts '  check in '+where+' ok'
    else
      raise 'My Exception'
    end

  end

  def to_be(driver,xpath,where)
    if driver.find_element(:xpath, xpath) == nil
      raise 'My Exception'
    else
      puts '  check in '+where+' ok'
    end
  end

  def not_to_be(driver,xpath,where)

    if driver.find_element(:xpath, xpath) == nil
      puts '  check in '+where+' ok'
    else
      raise 'My Exception'
    end

  end

end