require 'selenium-webdriver'
require 'yaml'
require 'page-object/platforms/selenium_webdriver/element'
require 'page-object'
require 'active_support'


class Page
  include PageObject

  # Берем файл main_config.yml по захардкоденому пути
  common_config = YAML.load_file('~/../configs/main_config.yml')
  stand = common_config['stand']
  CONFIG = common_config.merge!(YAML.load_file("~/../configs/#{stand}.yml")).freeze

  # direct upload files via window upload dialog
  def upload_file(element, file_path)
    puts file_path
    element.send_keys(file_path.tr('/', '\\'))
  end

  # deal with ck editor text areas
  def type_ck_editor(id, text)
    execute_script("CKEDITOR.instances['#{id}'].insertText('#{text}');")
  end

  # close all windows except current
  def close_other_windows
    cur_window = browser.window_handle
    browser.window_handles.each do |window|
      next if window.eql?(cur_window)

      browser.switch_to.window(window)
      browser.close
    end
    browser.switch_to.window(cur_window)
  end

  # switch to next window and close current
  def switch_next_window
    cur_window = browser.window_handle
    browser.close
    browser.window_handles.each do |window|
      next if window.eql?(cur_window)

      browser.switch_to.window(window)
      break
    end
  end

  def navigate_to_admin_page
    home_page = CONFIG['portal_page_url'].dup
    admin_address = home_page.insert(7, 'admin.')
    navigate_to(admin_address)
  end

  # Override selenium gem to make find element more exact. Selenium will try to find
  # element for some time. Override click to ignore wrappers around element.

  Selenium::WebDriver::SearchContext.module_eval do
    # need for find_element reconstruction
    def extract_args(args)
      case args.size
      when 3
        args
      when 2
        # base timeout for find_element
        args.push(10)
        args
      when 1
        arg = args.first
        unless arg.respond_to?(:shift)
          raise ArgumentError, "expected #{arg.inspect}:#{arg.class} to respond to #shift"
        end

        # this will be a single-entry hash, so use #shift over #first or #[]
        arr = arg.dup.shift
        unless arr.size == 2
          raise ArgumentError, "expected #{arr.inspect} to have 2 elements"
        end
        arr
      else
        raise ArgumentError, "wrong number of arguments (#{args.size} for 2)"
      end
    end

    # standard element search with 10 seconds default
    def find_element(*args)
      sleep 0.4
      how, what, timeout = extract_args(args)
      by = Selenium::WebDriver::SearchContext::FINDERS[how.to_sym]
      wait = Object::Selenium::WebDriver::Wait.new(timeout: timeout, message: 'element not found')
      wait.until do
        begin
          bridge.find_element_by(by, what.to_s, ref)
        rescue
          false
        end
      end
    rescue Selenium::WebDriver::Error::TimeOutError
      puts "element not found #{how} #{what}" if timeout > 3
      nil
    end
  end
end
