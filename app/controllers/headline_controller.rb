
class HeadlineController < ApplicationController

  def index
  end

  def search
    @headlines = []
    @headlines << find_headline(params[:headline])

    p @plucked_headlines = @headlines[0]["results"].first["results"]

      if @plucked_headlines != nil

        @results_headlines = @plucked_headlines.pluck("title", "location").to_h

         return render action: :search
      else
         # flash[:alert] = 'No headlines coming up under that search word.'
         return render action: :index
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
