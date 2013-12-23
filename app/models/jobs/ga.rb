class Jobs::Ga < Struct.new(:api_filz_id, :scope)
  
  def perform
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
      formatted_output = Core::Services.array_of_array_to_handsontable(output)
      final_output = Data::Query.query_1(formatted_output)
      #TODO APPEND output into data filz
      data_filz.update_attributes(:content => final_output)
      #EmailMailer.send_email(user.email, "Google Analytics - #{ak.to_s}").deliver
    rescue Exception => ex
      ak.update_attributes(error_message: ex.message.to_s)
    end
  end
    
end
