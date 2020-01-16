class HeadlineController < ApplicationController

  def index
  end

  def search
    headlines = find_headline(params[:headline])

    unless headlines
      flash[:alert] = 'No headlines coming up under that search word.'
      return render action: :index
    end
  end

  private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_headline(name)
    request_api(
      "https://financialtimesmikilior1v1.p.rapidapi.com/searchContent"
    )
  end

end
