
class HeadlineController < ApplicationController

  def index
  end

  def search
    headlines = find_headline(params[:headline])

    # unless headlines
    #   flash[:alert] = 'No headlines coming up under that search word.'
    #   return render action: :index
    # end

  p  @headlines = headlines
    # works locally but not on Heroku: headlines[0]["results"].pluck("title", "location").to_h
    # works locally but not on Heroku: headlines[0]["results"].first(20).pluck("title", "location").to_h
    # this gets first headline and nothing else: headlines[0]["results"][0]["title"]["title"]
    # .pluck("title", "location").to_h
    # works locally but not on Heroku: headlines.pluck("results").first.pluck("title", "location")
    # works locally but not on Heroku: headlines.to_a[1][1].pluck("results")[0].pluck("title", "location").to_h
    if headlines == nil
      flash[:alert] = 'No headlines coming up under that search word.'
      return render action: :index
    else @plucked_headlines = @headlines.pluck("title", "location").to_h
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
	       "resultContext" => {
           "maxResults" => "20",
           "offset" => "21",
		     "aspects" => [  "title", "location"
         ]
	}

}.to_json
    )
    JSON.parse(response.body)["results"][0]["results"]

  end

  def find_headline(search_word_params)

    request_api(
      "https://api.ft.com/content/search/v1/"
    )
  end

end
