module ApplicationHelper
  def render_joke_title(joke)
    title = joke.title
    return '' if title.blank?

    length = joke.photos.length
    if length > 1
      sub_title = content_tag 'span' do
        if action_name == "index"
          %Q((组图))
        else
          %Q((#{params[:photo].presence || 1}/#{joke.photos.count}))
        end
      end
      title << sub_title.to_s
    end

    %Q(<h4><a href="#{joke_path(joke)}">#{title}</a></h4>).html_safe
  end

  def render_joke_photo(joke)
    ind = params[:photo].to_i
    ind = 1 if ind.zero?
    ind = ind - 1
    
    if img = joke.photos[ind]
      image_tag img.normal.url
    end
  end

  def render_prev_joke_link(joke)
    ind = params[:photo].to_i
    ind = 1 if ind.zero?
    ind = ind - 1
    length = joke.photos.length
    prev_joke = Joke.where("id > ?", joke.id).order("id ASC").first

    if length < 2 || ind < 1
      joke_path(prev_joke) rescue nil
    else
      joke_path(joke, photo: ind)
    end 
  end

  def render_next_joke_link(joke)
    ind = params[:photo].to_i
    ind = 1 if ind.zero?
    ind = ind + 1  
    length = joke.photos.length
    next_joke = Joke.where("id < ?", joke.id).order("id DESC").first

    if length < 2 || ind > length
      joke_path(next_joke) rescue nil
    else
      joke_path(joke, photo: ind)        
    end     
  end

  def render_current_user_as_json
    u = if login?
      current_user
        .as_json(only: [:login, :bio])
        .merge(avatar: current_user.avatar_url)
    else
      nil
    end

    javascript_tag "window.current_user=#{u.to_json};"
  end   
end
