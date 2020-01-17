class HeadlineController < ApplicationController

  def index
  end

# the :headline param is coming from the index.html.erb file, user input field
  def search
    headlines = find_headline(params[:headline])

    unless headlines
      flash[:alert] = 'No headlines coming up under that search word.'
      return render action: :index
    end
  end

  private

  def request_api(url)
  p  response = Excon.post(
      url,
      headers: {
        'X-API-Host' => ("http://api.ft.com/content/search/v1?"),
        'X-API-Key' => ('59cbaf20e3e06d3565778e7bae03f49b50a742d89521203e74d426e5')
      }
    )
    # return nil if response.status != 200

  p  JSON.parse(response.body)
  end

# the api in the following method is possibly wrong
  def find_headline(name)
    request_api(
      "http://api.ft.com/content/search/v1?"
    )
  end

end
