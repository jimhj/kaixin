module ApplicationHelper
  def render_meta_tags(layout: 'application')
    site        = '笑话大全_最新搞笑图片_爆笑冷笑话精选_内涵段子幽默糗事_邪恶漫画_开心100'
    keywords    = %w(笑话 笑话大全 搞笑图片 冷笑话 邪恶漫画 幽默笑话 内涵段子 经典笑话 开心100)
    description = '开心100笑话大全与千万网友一起分享最新最热的爆笑笑话、搞笑图片、动态图、冷笑话、糗事笑话、成人笑话、内涵图、经典笑话、内涵段子、邪恶漫画等笑话大全。'

    conf = {
      reverse: true, 
      separator: '_', 
      suffix: '', 
      prefix: '',
      description: description,
      keywords: keywords
    }

    if layout == 'application'
      conf.merge!(site: site)
    end

    display_meta_tags(conf)
  end

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

  def render_joke_photo(joke, device: "desktop", link: nil)
    ind = params[:photo].to_i
    ind = 1 if ind.zero?
    ind = ind - 1
    
    if img = joke.photos[ind]
      content_tag 'div', class: 'photo' do
        version = (device == "desktop" ? :middle : :small)
        link ||= joke_path(joke)

        link_to link do
          image_tag img.url(version)
        end
      end
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
