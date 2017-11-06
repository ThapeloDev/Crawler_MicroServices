require 'pry'


Given(/^Go to thegioididong homepage$/) do
  visit 'https://www.thegioididong.com/dtdd'
end

When(/^Click loadmore in homepage$/) do
  # fill_in 'user_username', :with => "westmead_store_manager"
  # fill_in 'user_password', :with => "123456789"
  @loadmore_exist = true
  while @loadmore_exist
  	begin
  		load_more = page.find('.viewmore')
  	rescue
  		@loadmore_exist = false
  		break
  	end
  	load_more.click()
  end
  binding.pry
  a = Crawler::Crawler_Service.new
  # driver.findElement(By.className("viewmore")).click()
  # click_on 'user_login'
end

Then(/^Crawl all data in homepage$/) do
  # visit 'http://localhost:3000/admin/user_management'
  # page.should have_content "You are not authorized to access this page."
end