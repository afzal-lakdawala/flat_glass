require 'csv'
csv = []
a = [[1,2,3,4,5],[3,4,3]]
  CSV.generate do |csv| 
    a.each do |pr|
      csv << pr
    end
  end

puts csv

