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
    #/charts_images/    

    Viz::Chart.create(name: "Pie", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\" ],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/pie.png")
    Viz::Chart.create(name: "Donut", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/donut.png")
    Viz::Chart.create(name: "Bubble", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/bubble.png")
    #
    Viz::Chart.create(name: "Line", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/line.png")
    Viz::Chart.create(name: "Column", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/bar.png")
    Viz::Chart.create(name: "Area", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/area.png")
    Viz::Chart.create(name: "Bar", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/area.png")
    #
    Viz::Chart.create(name: "Scatter", genre:Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/scatter.png")
    Viz::Chart.create(name: "Circle Comparison", genre:Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/circle_comparison.png")
    #ad new 2d group, 2d stacked, 
    
    Viz::Chart.create(name: "Grouped Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Group\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/scatter.png")
    Viz::Chart.create(name: "Stacked Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Stack\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"]", img: "/charts_images/circle_comparison.png")
    Viz::Chart.create(name: "Grouped Stacked Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Y\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Group\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Stack\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"]", img: "/charts_images/circle_comparison.png")    
    
    #2d grouped adn stacked
    #
    Viz::Chart.create(name: "Packed Circle", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Tooltip\", \"string\", \"#{Viz::Chart::MAP_OPTIONAL}\"]]]", img: "/charts_images/packed_circle.png")
    Viz::Chart.create(name: "Tree Map", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Tooltip\", \"string\", \"#{Viz::Chart::MAP_OPTIONAL}\"]]]", img: "/charts_images/tree_rect.png")
    Viz::Chart.create(name: "Sunburst", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Size\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Tooltip\", \"string\", \"#{Viz::Chart::MAP_OPTIONAL}\"]]]", img: "/charts_images/sunburst.png")
    #
    Viz::Chart.create(name: "Circular Dendogram", genre:Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],\"Tooltip\", \"string\", \"#{Viz::Chart::MAP_OPTIONAL}\"]]]", img: "/charts_images/circular_dendogram.png")
    Viz::Chart.create(name: "Dendogram", genre:Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],\"Tooltip\", \"string\", \"#{Viz::Chart::MAP_OPTIONAL}\"]]]", img: "/charts_images/dendogram.png")
    #
    Viz::Chart.create(name: "Chord", genre:Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Link Value\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/chord.png")
    Viz::Chart.create(name: "Sankey", genre:Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\", \"#{Viz::Chart::MAP_MANDATORY}\"],[\"Link Value\", \"number\", \"#{Viz::Chart::MAP_MANDATORY}\"]]", img: "/charts_images/sankey.png")
    #
    Viz::Chart.create(name: "India States", genre:Viz::Chart::CHART_MAP, img: "")
    Viz::Chart.create(name: "India Districts", genre:Viz::Chart::CHART_MAP, img: "")
    Viz::Chart.all.each do |viz|
      viz.update_attributes(description: viz.name + " " + viz.genre)
    end
  end
  
  #rake seed:update
  task :update => :environment do |t, args|
    puts "Seeding Charts Reference Table"
    Viz::Chart.destroy_all
    #
    Viz::Chart.create(name: "Pie", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "/charts_images/pie.png")
    Viz::Chart.create(name: "Donut", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "/charts_images/donut.png")
    Viz::Chart.create(name: "Bubble", genre: Viz::Chart::CHART_1D, mapping: "[[\"Dimension\", \"string\"],[\"Size\", \"number\"]]", img: "/charts_images/bubble.png")
    #
    Viz::Chart.create(name: "Line", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"]]", img: "/charts_images/line.png")
    Viz::Chart.create(name: "Column", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"]]", img: "/charts_images/bar.png")
    Viz::Chart.create(name: "Area", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"]]", img: "/charts_images/area.png")
    Viz::Chart.create(name: "Bar", genre:Viz::Chart::CHART_2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"]]", img: "/charts_images/area.png")
    #
    Viz::Chart.create(name: "Scatter", genre:Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"],[\"Size\", \"number\"]]", img: "/charts_images/scatter.png")
    Viz::Chart.create(name: "Circle Comparison", genre:Viz::Chart::CHART_W2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"],[\"Size\", \"number\"]]", img: "/charts_images/circle_comparison.png")
    #ad new 2d group, 2d stacked, 
    
    Viz::Chart.create(name: "Grouped Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"],[\"Group\", \"string\"]]", img: "/charts_images/scatter.png")
    Viz::Chart.create(name: "Stacked Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"],[\"Stack\", \"string\"]", img: "/charts_images/circle_comparison.png")
    Viz::Chart.create(name: "Grouped Stacked Column", genre:Viz::Chart::CHART_GS2D, mapping: "[[\"X\", \"string\"],[\"Y\", \"number\"],[\"Group\", \"string\"],[\"Stack\", \"string\"]", img: "/charts_images/circle_comparison.png")
    
    
    #2d grouped adn stacked
    #
    Viz::Chart.create(name: "Packed Circle", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]", img: "/charts_images/packed_circle.png")
    Viz::Chart.create(name: "Tree Map", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]", img: "/charts_images/tree_rect.png")
    Viz::Chart.create(name: "Sunburst", genre:Viz::Chart::CHART_WT, mapping: "[[\"Hierarchy\", \"string\"],[\"Size\", \"number\"],[\"Tooltip\", \"string\"]]", img: "/charts_images/sunburst.png")
    #
    Viz::Chart.create(name: "Circular Dendogram", genre:Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\"],\"Tooltip\", \"string\"]]", img: "/charts_images/circular_dendogram.png")
    Viz::Chart.create(name: "Dendogram", genre:Viz::Chart::CHART_T, mapping: "[[\"Hierarchy\", \"string\"],\"Tooltip\", \"string\"]]", img: "/charts_images/dendogram.png")
    #
    Viz::Chart.create(name: "Chord", genre:Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\"],[\"Link Value\", \"number\"]]", img: "/charts_images/chord.png")
    Viz::Chart.create(name: "Sankey", genre:Viz::Chart::CHART_RELATION, mapping: "[[\"Dimensions\", \"string\"],[\"Link Value\", \"number\"]]", img: "/charts_images/sankey.png")
    #
    Viz::Chart.create(name: "India States", genre:Viz::Chart::CHART_MAP, img: "")
    Viz::Chart.create(name: "India Districts", genre:Viz::Chart::CHART_MAP, img: "")
    Viz::Chart.all.each do |viz|
      viz.update_attributes(description: viz.name + " " + viz.genre)
    end
  end
  
end