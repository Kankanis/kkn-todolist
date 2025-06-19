require 'cucumber/rails'
require 'selenium-webdriver'

# --- เพิ่มส่วนนี้เข้าไปเพื่อตั้งค่าให้เบราว์เซอร์แสดงผล ---
Capybara.register_driver :visible_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# บอกให้ Capybara ใช้ driver ที่เราสร้างขึ้นเมื่อมีการรันเทสต์ที่ต้องใช้ JavaScript
Capybara.javascript_driver = :visible_chrome
# ----------------------------------------------------

ActionController::Base.allow_rescue = false

Before do
  # Clean up before each scenario
  Quest.delete_all if defined?(Quest)
end

After do |scenario|
  # Clean up after each scenario
  Quest.delete_all if defined?(Quest)
end
