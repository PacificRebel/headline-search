
class HeadlineController < ApplicationController

  def index
  end

  def search
    headlines = find_headline(params[:headline])

    unless headlines
      flash[:alert] = 'No headlines coming up under that search word.'
      return render action: :index
    end

    p @headlines = headlines.to_a[1][1].pluck("results")[0].pluck("title", "location").to_h

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
    JSON.parse(response.body)

  end

  def find_headline(title)

    request_api(
      "https://api.ft.com/content/search/v1/"
    )
  end

end
