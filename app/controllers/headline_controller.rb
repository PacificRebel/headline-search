
class HeadlineController < ApplicationController

  def index
  end

  def search
    headlines = []
   headlines << find_headline(params[:headline])

    @headlines_reduced = headlines[0]["results"]
    if @headlines_reduced[0]["indexCount"] == 0
      return render action: :index

    else
      @plucked_headlines = @headlines_reduced.try(:first).try(:[], "results").try(:pluck, "title", "location").to_h

    end
  end
end
  private

  def request_api(url)
    response = Excon.post(
      url,
      headers: {
        'X-API-Key' => Figaro.env.X_API_KEY,
        'Content-Type' => 'application/json'},
      body: {
	       "queryString" => params[:headline],
         "queryContext"=> {
           "curations"=> ["ARTICLES"]
         },
	       "resultContext" => {
           "maxResults" => "20",
           "offset" => "21",
		     "aspects" => [  "title", "location"
         ]
	}

}.to_json
    )
    JSON.parse(response.body)

  end

def find_headline(search_word_params)

    request_api(
      "https://api.ft.com/content/search/v1/"
    )
  end
