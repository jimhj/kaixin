class AdController < ApplicationController
  skip_before_action :verify_authenticity_token

  def recommends
    @ad_width = params[:width].presence || '100%'
    @ad_height = params[:height].presence || '250'
    gap = params[:gap].presence || '10'
    number = params[:number].presence || 8
    @tag_id = params[:t]
    host = if Rails.env.development?
      '127.0.0.1'
    else
      'www.kaixin100.com'
    end
    @request_url = ad_pics_url(c: params[:c], number: number, gap: gap, host: host)

    respond_to do |format|
      format.js { render file: "ad/recommends.js.erb" }
    end
  end

  def pics
    number = params[:number].presence || 8
    @gap = params[:gap]
    @hmsr = params[:c]
    @recommends = Joke.recommend(number.to_i)
    headers['X-Frame-Options'] = "ALLOWALL"
    render template: 'ad/pics', layout: false
  end
end