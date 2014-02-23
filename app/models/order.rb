class Order < ActiveRecord::Base
  #GEMS USED
  #ACCESSORS
  attr_accessible :cust_nr, :no_orders, :day, :month, :year, :avg_margin, :site_code, :cur_code, :avg_del_time, :date
  #ASSOCIATIONS
  #VALIDATIONS
  #CALLBACKS  
  #SCOPES  
  #CUSTOM SCOPES
  def self.getGroupedlast31Days
    today    = Date.today.strftime("%Y-%m-%d")
    previous = 10000.days.ago.strftime("%Y-%m-%d")
    Order.group(:date).where(date: previous..today)
         .select("sum(no_orders) as value, date as label").order(:date).limit(30)
  end

  def self.changeDateFormat
    for i in 1..Order.count      
       puts "Updating record - #{i} ........."
       order = Order.find_by_id(i)
       date = order.year.to_s + "-" + order.month.to_s + "-" + order.day.to_s
       Order.where(id: i).update_all(date:date)
    end      
  end
  #OTHER METHODS
  #UPSERT  
  #JOBS
  #PRIVATE
  private      

end
