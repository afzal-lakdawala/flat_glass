class Jobs::Ga < Struct.new(:api_account_id, :data_query_id, :scope)
  
  def perform
    begin
      if scope == "today"
        start_date = "" #"2013-06-14"
        end_date = ""
      else
        start_date = ""
        end_date = ""
      end
      
      #start_date = "2013-12-22"
      #end_date = start_date
      #api_account_id = 9
      #data_query_id = 1
      
      account = Api::Account.find(api_account_id)
      query = Data::Query.find(data_query_id)
      account.api_oauth.reauthenticate?
      api_output = query.ga(account.api_oauth.token, start_date, end_date, account.api_profile_id)
      formatted_output = Core::Services.array_of_array_to_handsontable(output)
      final_output = Data::Query.query_1(formatted_output)
  
      
      
      
      

      EmailMailer.send_email(user.email, "Google Analytics - #{ak.to_s}").deliver
    rescue Exception => ex
      ak.update_attributes(error_message: ex.message.to_s)
    end
  end
    
end
