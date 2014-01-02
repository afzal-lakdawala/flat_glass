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

  def self.get_headers(data)
    headings = data.shift
    stats = []
    headings.size.times do |i|
      stat = {}
      stat["col"] = headings[i]
      data.each do |row|
        type = Data::FilzColumn.tell_datatype(row[i])
        stat[type] = stat.has_key?(type) ? (stat[type] + 1) : 1
      end
      stats.push(stat)
    end
    headers = []
    stats.each do |s|
      if s["col"].present?
        if s.keys.size == 2
          name = s["col"]
          name = (name.include? ":") ? name.split(":")[0] : name
          headers.push "#{s['col']}:#{s.keys.last}"
        else
          name = s["col"]
          name = (name.include? ":") ? name.split(":")[0] : name
          s.delete("col")
          type = s.sort.last.first
          headers.push "#{name}:#{type}"
        end
      end
    end
    return headers.join(",")
  end

  #UPSERT
  #JOBS
  #PRIVATE
  private

  def self.tell_datatype(v)

    # Date Conjectures
    # Is a non decimal integer
    if v.to_s.match(/^[\d]+(\.[\d]+){0,1}$/).nil? == false && v.to_f % 1 == 0
      return "date-day?" if (1..31).include? v.to_i      # Day
      return "date-month?" if (1..12).include? v.to_i      # Month
      return "date-year?" if (1000..2020).include? v.to_i # Year
    end

    iso = ["IN_AP", "IN_AR", "IN_AS", "IN_BR", "IN_CG", "IN_GA", "IN_GJ", "IN_HP", "IN_HR", "IN_JH", "IN_JK", "IN_KA", "IN_KL", "IN_MH", "IN_ML", "IN_MN", "IN_MP", "IN_MZ", "IN_NL", "IN_OR", "IN_PB", "IN_RJ", "IN_SK", "IN_TN", "IN_TR", "IN_UP", "IN_UT", "IN_WB"] # TODO Load ISO Data from some place sane!
    return "number" unless v.to_s.match(/^[\d]+(\.[\d]+){0,1}$/) == nil
    return "iso"    if iso.include? v.to_s
    return "date"   if Date.parse(v.to_s) rescue nil == nil
    return "string"
  end

end
