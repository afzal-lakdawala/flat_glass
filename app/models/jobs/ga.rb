class Jobs::Ga
  
  def self.query(api_filz_id, scope)
    begin
      if scope == "today"
        start_date = Core::Services.convert_date_to_google_analytics_format((Date.today - 1))
        end_date = start_date
      else
        start_date = Core::Services.convert_date_to_google_analytics_format((Date.today - 30))
        end_date = Core::Services.convert_date_to_google_analytics_format((Date.today - 1))
      end
      api_filz = Api::Filz.find(api_filz_id)
      account = api_filz.api_account
      query = api_filz.data_query
      data_filz = api_filz.data_filz
      account.api_oauth.reauthenticate?
      api_output = query.ga(account.api_oauth.token, start_date, end_date, account.api_profile_id)
      formatted_output = Core::Services.array_of_array_to_handsontable(api_output)
      final_output = Data::Query.query_1(formatted_output)
      #TODO - worry about the scenario when datatype is already set and new data appended
      o = []
      if data_filz.content.blank?
        o << api_filz.data_query.header_row.split(",")
      end
      o = o + final_output
      data_filz.update_attributes(:content => o)
    rescue Exception => ex
      api_filzs.update_attributes(error_string: ex.message.to_s)
    end
  end
    
end
