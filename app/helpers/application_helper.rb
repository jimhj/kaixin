module ApplicationHelper
  def render_joke_title(joke)
    title = joke.title
    length = joke.photos.length

    if length > 1
      sub_title = content_tag 'span' do
        %Q(  (#{params[:photo].presence || 1}/#{joke.photos.count}))
      end
      title << sub_title.to_s
    end
    title.html_safe
  end

  def render_joke_photo(joke)
    ind = params[:photo].to_i - 1
    if ind < 0
      ind = 0
    end
    
    if img = joke.photos[ind]
      image_tag img.url
    end
  end

  def render_prev_joke_link(joke)
    ind = params[:photo].to_i
    if ind.zero?
      ind = 1
    end
    
    length = joke.photos.length
    prev_joke = Joke.where("id > ?", joke.id).order("id ASC").first

    if length < 2
      joke_path(prev_joke) rescue url_for
    else
      ind = ind - 1
      if ind <= 0
        joke_path(prev_joke) rescue url_for
      else
        joke_path(joke, photo: ind)
      end
    end 
  end

  def render_next_joke_link(joke)
    ind = params[:photo].to_i
    if ind.zero?
      ind = 1
    end

    length = joke.photos.length
    next_joke = Joke.where("id < ?", joke.id).order("id DESC").first

    if length < 2
      joke_path(next_joke) rescue nil
    else
      ind = ind + 1      
      if ind > length
        joke_path(next_joke) rescue nil
      else
        joke_path(joke, photo: ind)        
      end
    end     
  end    
end
