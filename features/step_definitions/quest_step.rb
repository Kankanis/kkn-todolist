Before do
  Quest.destroy_all
end

# === Given Steps ===

Given('there are no quests') do
  Quest.destroy_all
end

Given('I am on the quests index page') do
  visit quests_path
end


Given('there is a quest named {string}') do |quest_name|
  FactoryBot.create(:quest, name: quest_name)
end

# === When Steps ===

When('I click {string}') do |text_or_locator|
  begin
    click_link text_or_locator
  rescue Capybara::ElementNotFound
    click_button text_or_locator
  end
end

When('I click the {string} button') do |button_name_or_testid_description|
  case button_name_or_testid_description
  when "back to quests"
    save_and_open_page
    element = find('[data-testid="back-to-quests-button"]', visible: :all, wait: 5)

    element.click

  when "plus"
    find('[data-testid="add-quest-button"]').click
  when "Save"
    click_button 'Save'
  else
    begin
      find_button(button_name_or_testid_description).click
    rescue Capybara::ElementNotFound
      find("[data-testid='#{button_name_or_testid_description}-button']").click
    end
  end
end

# === Then Steps ===

Then('I should see {string} as the page title') do |title_text|
  expect(page).to have_title title_text
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text, wait: 5)
end

Then('I should not see {string}') do |text|
  expect(page).to have_no_content(text, wait: 5)
end

Then('I should be on the brag page') do
  expect(page).to have_current_path(brag_path)
end

Then('I should be on the quests index page') do
  expect(page).to have_current_path("/", wait: 10)
end

Then('I should see an input field with placeholder {string}') do |placeholder_text|
  expect(page).to have_field(placeholder_text)
end

Then('I should see the {string} button') do |button_name_or_testid_description|
  case button_name_or_testid_description
  when "plus"
    expect(page).to have_selector('button i.fas.fa-plus[data-testid="add-quest-button"]')
  when "back to quests"
    expect(page).to have_selector('[data-testid="back-to-quests-button"]')
  when "Save"
    expect(page).to have_button("Save")
  else

    expect(page).to have_button(button_name_or_testid_description)
  end
end
