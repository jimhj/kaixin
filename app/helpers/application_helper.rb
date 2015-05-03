module ApplicationHelper
  def render_joke_title(joke)
    title = joke.title
    current = params[:photo].presence || 1

    if joke.photos.length > 1
      sub_title = "(#{current}/#{joke.photos.count})"
      title << sub_title
    end
    title
  end

  def render_joke_photo(joke)
    current = params[:photo].presence || 1
    ind = current - 1
    if ind < 0
      ind = 0
    end
    photo = joke.photos[ind]
    image_tag photo
  end

  def render_prev_joke_link(joke)
    if self.photos.length == 1
      joke = Joke.where("id > ?", id).order("id ASC").first
      joke_path(joke)
    else
      
    end 
  end

  def next_link
    Joke.where("id < ?", id).order("id DESC").first    
  end    
end
