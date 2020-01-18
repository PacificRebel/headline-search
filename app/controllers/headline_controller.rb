
class HeadlineController < ApplicationController

  def index
  end


# the :queryString param is coming from the index.html.erb file, user input field
  def search
    headlines = find_headline(params[:headline])

    unless headlines
      flash[:alert] = 'No headlines coming up under that search word.'
      return render action: :index
    end
    @headlines = headlines
  end

  private

  def request_api(url)
  p  response = Excon.post(
      url,
      headers: {
        # 'X-API-Host' => URI.parse(url).host,
        'X-API-Key' => '59cbaf20e3e06d3565778e7bae03f49b50a742d89521203e74d426e5',
        # 'X-API-Key' => Figaro.env.X_API_KEY
        'Content-Type' => 'application/json'},
      body: {
	       "queryString" => params[:title],
	       "resultContext" => {
		     "aspects" => [  "title","lifecycle","location","summary","editorial" ]
	}

      }.to_json
    )
    # return nil if response.status != 200

    @headlines = JSON.parse(response.body)
  end

  def find_headline(title)
    query = URI.encode("#{title}")

    request_api(
      "https://api.ft.com/content/search/v1"
      # "https://api.ft.com/content/search/v1?apiKey=59cbaf20e3e06d3565778e7bae03f49b50a742d89521203e74d426e5"
      # "http://api.ft.com/content/search/v1?59cbaf20e3e06d3565778e7bae03f49b50a742d89521203e74d426e5=&Content-Type=application/jason/"
    )
  end

end

# response = Unirest.post uri, headers:{"content-length" => "500", "content-type" => "application/json", "authorization" => "Bearer" + " " + apikey}, parameters: {"Inputs" => {"input1" => {"ColumnNames" => ["Case Number", "Case Type", "Address", "Description", "Case Group", "Date Case Created", "Last Inspection Date", "Last Inspection Result", "Status", "Permit and Complaint Status URL", "Latitude", "Longitude", "Location"], "Values" => [["0", "value","value","value","value","", "","value","value","value","0", "0", "value"],["0", "value","value","value","value","", "","value","value","value","0", "0", "value"]]}}, "GlobalParameters" => {}}.to_json
