require 'spec_helper'
require 'capybara_helper'

feature 'Find Tweets', :js => true do
  include DBHelper

  before do
    visit root_path
  end

  context 'after page loading' do
    scenario 'should contain latitude field' do
      page.should have_css('input#latitude')
    end

    scenario 'should contain longitude field' do
      page.should have_css('input#longitude')
    end

    scenario 'should contain radius field' do
      page.should have_css('input#radius')
    end

    scenario 'should contain hashtag field' do
      page.should have_css('input#hash_tag')
    end

    scenario 'should contain submit button' do
      page.should have_css('button#searchbutton')
    end

    scenario 'page should render google maps' do
      page.should have_css('div#map-canvas')
      within("div#map-canvas") do
        page.should have_css('div.gmnoprint')
        page.should have_content(/Map data.*2014 Google, INEGI/)
        page.should have_content("Terms of Use")
      end
    end
  end  

  context 'input box validation' do
    scenario 'validation for missing latitude longitude and radius' do
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 3)
      end  
    end

    scenario 'validation for missing latitude and longitude' do
      fill_in('radius', :with => '10')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 2)
      end  
    end

    scenario 'validation for missing longitude and radius' do
      fill_in('latitude', :with => '122.123')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 2)
      end  
    end

    scenario 'validation for missing latitude and radius' do
      fill_in('longitude', :with => '122.123')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 2)
      end  
    end

    scenario 'validation for missing latitude only' do
      fill_in('longitude',  :with => '122.123')
      fill_in('radius', :with => '10')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 1)
      end  
    end

    scenario 'validation for missing longitude only' do
      fill_in('latitude',  :with => '122.123')
      fill_in('radius', :with => '10')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 1)
      end  
    end  

    scenario 'validation for missing radius only' do
      fill_in('latitude',  :with => '122.123')
      fill_in('longitude', :with => '-22.123')
      click_button('Search')

      page.should have_css('p.help-block')
      within('p.help-block') do
        page.should have_css('span.font-red', :count => 1)
      end  
    end    
  
  end

  context 'click search' do
    scenario 'should alert for no tweets' do
      fill_in('latitude',  :with => '78')
      fill_in('longitude', :with => '123')
      fill_in('radius', :with => '10')
      click_button('Search')
      
      page.should have_content('No tweets found')
    end  

    scenario 'should show pagination if tweets found' do
      populate_db
      fill_in('latitude',  :with => '46.7495931')
      fill_in('longitude', :with => '-92.1179976')
      fill_in('radius',    :with => '0.1')
      click_button('Search')

      page.should have_selector('#no-result', visible: false)
      page.should have_selector('#pagination_panel', visible: true)
    end

    scenario 'should paginate on previous and next click' do
      populate_db
      fill_in('latitude',  :with => '46.7495931')
      fill_in('longitude', :with => '-92.1179976')
      fill_in('radius',    :with => '5')
      click_button('Search')
      
      page.should have_selector('#no-result', visible: false)
      page.should have_selector('#pagination_panel', visible: true)

      find("span#next-btn").click

      within("div#pagination_panel") do
        page.should have_content('2', :count => 2)
      end

      find("span#prev-btn").click
      within("div#pagination_panel") do
        page.should have_content('1')
        page.should have_content('2', :count => 1)
      end

    end  
  end  

end