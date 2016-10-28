require 'selenium-webdriver'
require 'page-object/platforms/selenium_webdriver/element'
require 'page-object'
require 'yaml'

class Page
  include PageObject

  CONFIG = YAML.load_file('~/../config.yaml').freeze

  def initialize(root, visit = false)
    super(root, visit)
  end

  def navigate_recent_company
    recent_company_link = "#{CONFIG['portal_page']}/firms/new/approval"
    navigate_to(recent_company_link)
  end

  def navigate_company_site(company_id)
    navigate_to("#{CONFIG['portal_page']}/firms/#{company_id}")
  end

  def navigate_home
    navigate_to(CONFIG['portal_page'])
    self
  end

  def close_other_windows
    cur_window = browser.window_handle
    browser.window_handles.each do |window|
      unless window.eql? cur_window
        browser.switch_to.window(window)
        browser.close
      end
    end
    browser.switch_to.window(cur_window)
  end

  def navigate_admin_page
    buf = CONFIG['portal_page'].dup
    admin_address = buf.insert(7, 'admin.')
    navigate_to(admin_address)
    self
  end

  Selenium::WebDriver::Element.class_eval do
    attr_reader :bridge, :id

    def click
      wait = Object::Selenium::WebDriver::Wait.new(timeout: 1, message: 'click failed')
      wait.until do
        begin
          bridge.click_element id
          true
        rescue Exception => e
          puts id
          puts e.message
          puts e.backtrace.inspect
          false
        end
      end
    end
  end

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
      sleep 0.1
      how, what, timeout = extract_args(args)
      by = Selenium::WebDriver::SearchContext::FINDERS[how.to_sym]
      wait = Object::Selenium::WebDriver::Wait.new(timeout: timeout, message: 'element not found')
      wait.until do
        element = bridge.find_element_by by, what.to_s, ref
        !element.nil? && element.displayed? ? element : false
      end
    rescue Selenium::WebDriver::Error::TimeOutError
      puts "element not found #{how} #{what}" if timeout > 1
      nil
    end
  end

  # lets make 1 second {name}? waiting
  PageObject::Accessors.module_eval do
    def standard_methods(name, identifier, method, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.send(method, identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier.clone
        element = browser.find_element(how, what, 1)
        !element.nil?
      end
    end
  end
end
