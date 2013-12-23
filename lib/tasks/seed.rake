namespace :seed do
    
  #rake seed:db
  
  task :db => :environment do |t, args|
    
    puts "Seeding"
    u = User.new(email: "rp@pykih.com", password: "pykih123", name: "amdocs", username: "amdocs")
    u.skip_confirmation!
    u.save
    
    Data::Query.create!(name: "Query 1", source: "GA", metrics: "ga:visitors,ga:newVisits,ga:visits,ga:bounces,ga:avgTimeOnSite,ga:pageviewsPerVisit,ga:pageviews,ga:avgTimeOnPage,ga:exits", dimensions: "ga:date,ga:country,ga:sourceMedium,ga:keyword,ga:deviceCategory,ga:pagePath,ga:landingPagePath", header_row: "{\"0\":\"date\", \"1\":\"country\", \"2\":\"sourceMedium\", \"3\":\"keyword\", \"4\":\"deviceCategory\", \"5\":\"pagePath\", \"6\":\"landingPagePath\", \"7\":\"visitors\", \"8\":\"newVisits\", \"9\":\"visits\", \"10\":\"bounces\", \"11\":\"avgTimeOnSite\", \"12\":\"pageviewsPerVisit\", \"13\":\"pageviews\", \"14\":\"avgTimeOnPage\", \"15\":\"exits\",\"16\":\"year\",\"17\":\"month\",\"18\":\"day\",\"19\":\"source\",\"20\":\"medium\"}", description: "adnfldaknf adlfkn adlf nadfl adkfn")
    
  end
  
end