
class HeadlineController < ApplicationController

  def index
  end

  def search
    @headlines = []
    @headlines << find_headline(params[:headline])

    @headlines_abridged = @headlines[0]["results"]

    @indexCount = @headlines_abridged.dig("indexCount")

      if @headlines_abridged.present?
         @plucked_headlines = @indexCount.first["results"].dig("title", "location").to_h
         #is this follwing line correct? Why is Heroku rendering headline.index.html.erb when there's a result?
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
           "maxResults" => "5",
           "offset" => "6",
		     "aspects" => [  "title", "location"
         ]
	}

}.to_json
    )
    p JSON.parse(response.body)

  end

def find_headline(search_word_params)

    request_api(
      "https://api.ft.com/content/search/v1/"
    )
  end
