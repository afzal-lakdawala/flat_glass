namespace :seed do
    
  #rake seed:db
  
  task :db => :environment do |t, args|
    puts "Seeding User"
    User.destroy_all
    u = User.new(email: "rp@pykih.com", password: "pykih123", name: "amdocs", username: "amdocs")
    u.skip_confirmation!
    u.save
    puts "Seeding GA Query"
    Data::Query.destroy_all
    Data::Query.create!(name: "Query 1", source: "GA", metrics: "ga:visitors,ga:newVisits,ga:visits,ga:bounces,ga:avgTimeOnSite,ga:pageviewsPerVisit,ga:pageviews,ga:avgTimeOnPage,ga:exits", dimensions: "ga:date,ga:country,ga:sourceMedium,ga:keyword,ga:deviceCategory,ga:pagePath,ga:landingPagePath", header_row:  "date,country,sourceMedium,keyword,deviceCategory,pagePath,LandingPagePath,visitors,newVisits,visits,bounces,avgTimeOnSite,pageviewsPerVisit,pageviews,avgTimeOnPage,exits,year,month,day,source,medium", description: "adnfldaknf adlfkn adlf nadfl adkfn")
    puts "Seeding Charts Reference Table"
    Viz::Chart.destroy_all
    #
    Viz::Chart.create(name: "Pie", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/1d/pie.png")
    Viz::Chart.create(name: "Donut", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/1d/donut.png")
    Viz::Chart.create(name: "Bubble", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/1d/bubble.png")
    #
    Viz::Chart.create(name: "Line", Viz::Chart::CHART_2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/line.png")
    Viz::Chart.create(name: "Column", Viz::Chart::CHART_2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/bar.png")
    Viz::Chart.create(name: "Area", Viz::Chart::CHART_2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/area.png")
    Viz::Chart.create(name: "Bar", Viz::Chart::CHART_2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/area.png")
    #
    Viz::Chart.create(name: "Scatter", Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"],[\"Size\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/scatter.png")
    Viz::Chart.create(name: "Circle Comparison", Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"number\"],[\"Y\", \"number\"],[\"Size\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/2d/circle_comparison.png")
    #ad new 2d group, 2d stacked, 
    #2d grouped adn stacked
    #
    Viz::Chart.create(name: "Packed Circle", Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/weighted_tree/packed_circle.png")
    Viz::Chart.create(name: "Tree Map", Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/weighted_tree/tree_rect.png")
    Viz::Chart.create(name: "Sunburst", Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/weighted_tree/sunburst.png")
    #
    Viz::Chart.create(name: "Circular Dendogram", Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\"],\"Tooltip\", \"string\"]]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/unweighted_tree/circular_dendogram.png")
    Viz::Chart.create(name: "Dendogram", Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\"],\"Tooltip\", \"string\"]]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/unweighted_tree/dendogram.png")
    #
    Viz::Chart.create(name: "Chord", Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\"],[\"Link Value\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/relations/chord.png")
    Viz::Chart.create(name: "Sankey", Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\"],[\"Link Value\", \"number\"]]", img: "https://s3-ap-southeast-1.amazonaws.com/pykhub/chart_types/relations/sankey.png")
    #
    Viz::Chart.create(name: "India States", genre: Viz::Chart::CHART_MAP, img: "")
    Viz::Chart.create(name: "India Districts", genre: Viz::Chart::CHART_MAP, img: "")
    
  end
  
  #rake seed:update
  task :update => :environment do |t, args|
    Viz::Viz.destroy_all
    Viz::Chart.where(genre: Viz::Chart::CHART_1D).update_all(mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]")
    Viz::Chart.all.each do |viz|
      viz.update_attributes(description: viz.name + " " + viz.genre)
    end
  end
  
end