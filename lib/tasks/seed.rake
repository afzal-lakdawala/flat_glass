namespace :seed do
    
  #rake seed:db
  
  task :db => :environment do |t, args|
    
    puts "Seeding"
    u = User.new(email: "rp@pykih.com", password: "pykih123", name: "amdocs", username: "amdocs")
    u.skip_confirmation!
    u.save
    
    Data::Query.create!(name: "Query 1", source: "GA", metrics: "ga:visitors,ga:newVisits,ga:visits,ga:bounces,ga:avgTimeOnSite,ga:pageviewsPerVisit,ga:pageviews,ga:avgTimeOnPage,ga:exits", dimensions: "ga:date,ga:country,ga:sourceMedium,ga:keyword,ga:deviceCategory,ga:pagePath,ga:landingPagePath", header_row:  "date,country,sourceMedium,keyword,deviceCategory,pagePath,LandingPagePath,visitors,newVisits,visits,bounces,avgTimeOnSite,pageviewsPerVisit,pageviews,avgTimeOnPage,exits,year,month,day,source,medium", description: "adnfldaknf adlfkn adlf nadfl adkfn")
    
  end
  
end