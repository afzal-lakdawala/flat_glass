class Data::FilzColumn < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :data_filz_columns
  has_paper_trail
  
  #ACCESSORS
  attr_accessible :data_filz_id, :datatype, :name
  
  #ASSOCIATIONS
  belongs_to :data_filz, :class_name => 'Data::Filz', :foreign_key => "data_filz_id"
  
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  #UPSERT
  #def self.upsert(dfid, dt, na)
    #d = Data::FilzColumn.where(data_filz_id: dfid, name: na).first
    #if d.blank?
      #d = Data::FilzColumn.new(data_filz_id: dfid, name: na)
      #end
    #end
  
  def self.determine_headers(content)
    c = JSON.parse(content)
    
    
    
    headers = []
    stats = []
    
    is_not_first_row = false
    c.each do |row|
      i = 0
      row.each do |col|
        if is_not_first_row
           
        else
          stats[col] = ""
        end
        i = i + 1
      end
      is_not_first_row = true
    end
    
  end
  
  def self.get_headers
    self.getStats
    headers = []
    @stats.each do |s|
      if s.keys.size == 2
        headers.push "#{s['col']}:#{s.keys.last}"
      else
        name = s["col"]
        s.delete("col")
        type = s.sort.last.first
        headers.push "#{name}:#{type}"
      end
    end
    return headers.join(",")
  end
    
  def getStats
    @stats = []
    @headings.size.times do |i|
      stat = {}
      stat["col"] = @headings[i]
      @data.each do |row|
        type = tell_datatype(row[i])
        if stat.has_key?(type)
          stat[type] += 1
        else
          stat[type] = 1
        end
      end
      @stats.push(stat)
    end
  end
  
  #JOBS
  #PRIVATE
  private
  
  def self.tell_datatype(v)
    iso = ["IN_AP", "IN_AR", "IN_AS", "IN_BR", "IN_CG", "IN_GA", "IN_GJ", "IN_HP", "IN_HR", "IN_JH", "IN_JK", "IN_KA", "IN_KL", "IN_MH", "IN_ML", "IN_MN", "IN_MP", "IN_MZ", "IN_NL", "IN_OR", "IN_PB", "IN_RJ", "IN_SK", "IN_TN", "IN_TR", "IN_UP", "IN_UT", "IN_WB"] # TODO Load ISO Data from some place sane!
    return "number" unless v.match(/^[\d]+(\.[\d]+){0,1}$/) == nil
    return "iso"    if iso.include? v
    return "date"   if Date.parse(v) rescue nil == nil
    return "string"
  end
  
end
