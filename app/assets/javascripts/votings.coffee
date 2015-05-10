kaixin.up_vote_jokes = ->
  up = kaixin.cookies.get 'up_vote_jokes'
  up = (up || '').split(',')
  $.unique up

kaixin.down_vote_jokes = ->
  down = kaixin.cookies.get 'down_vote_jokes'
  down = (down || '').split(',')  
  $.unique down

kaixin.voted_jokes = ->
  up    = kaixin.up_vote_jokes()
  down  = kaixin.down_vote_jokes()
  r     = $.merge up, down
  $.unique r

kaixin._updateIco = ($i) ->  
  klasses = $i.attr('class').split(' ')
  kx      = klasses[0]
  ico     = klasses[1]
  ico     = ico.replace /d$/, ''
  $i.attr 'class', "#{kx} #{ico}"

kaixin.updateVoteState = ->
  for joke_id in kaixin.up_vote_jokes()
    if joke_id != "" and joke_id != undefined
      $i = $("a.ding[data-votable_id='#{joke_id}']").find('i')
      kaixin._updateIco $i

  for joke_id in kaixin.down_vote_jokes()
    if joke_id != "" and joke_id != undefined
      $i = $("a.cai[data-votable_id='#{joke_id}']").find('i')
      kaixin._updateIco $i


$(document).ready ->
  # 更新当前客户端顶和踩的状态
  kaixin.updateVoteState()

  # 顶 和 踩
  $('body').on 'click', 'a.ding, a.cai', ->
    $t                 = $(this)
    votable            = $t.data 'votable_type'
    votable_id         = $t.data 'votable_id'
    vote               = $t.data 'vote'
    url                = "/#{votable}/#{votable_id}/#{vote}"
    cache_key          = "#{vote}_#{votable}"  
    cached             = (kaixin.cookies.get(cache_key) || '').split(',')
    
    if kaixin.voted_jokes().indexOf("#{votable_id}") >= 0 or cached.indexOf("#{votable_id}") >= 0
      console.log "已经投过票了"
      return false

    $num = $t.find('span:last')
    number = parseInt $num.text()      
    $num.text number + 1
    cached.push votable_id
    kaixin.cookies.set cache_key, cached.join(',')

    $i      = $t.find 'i'
    kaixin._updateIco $i

    $.post url
