kaixin._getArray = (str)->
  array = (str || '').split(',')
  array = kaixin.compact array
  $.unique array

kaixin.up_vote_jokes = ->
  up = kaixin.cookies.get 'up_vote_jokes'
  kaixin._getArray up

kaixin.down_vote_jokes = ->
  down = kaixin.cookies.get 'down_vote_jokes'
  kaixin._getArray down

kaixin.voted_jokes = ->
  up    = kaixin.up_vote_jokes()
  down  = kaixin.down_vote_jokes()
  r     = $.merge up, down
  $.unique r

kaixin.voted_comments = ->
  up = kaixin.cookies.get "up_vote_comments"
  kaixin._getArray up

kaixin._updateIco = ($i) ->  
  return if $i.length == 0
  klass = $i.attr 'class'
  klass = klass.replace /d$/, ''
  $i.attr 'class', klass

kaixin.updateVoteState = ->
  for joke_id in kaixin.up_vote_jokes()
    $i = $("a.ding[data-votable_id='#{joke_id}']").find('i')
    kaixin._updateIco($i)

  for joke_id in kaixin.down_vote_jokes()
    $i = $("a.cai[data-votable_id='#{joke_id}']").find('i')
    kaixin._updateIco($i)

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

    if cached.indexOf("#{votable_id}") >= 0
      console.log '已经投过票了'
      return false

    if votable == "jokes" and kaixin.voted_jokes().indexOf("#{votable_id}") >= 0 
      console.log '已经投过票了'
      return false

    $num = $t.find('span')
    if $num.length == 0
      $num = $t.find('small')

    number = parseInt $num.text()      
    $num.text number + 1
    cached.push votable_id
    kaixin.cookies.set cache_key, cached.join(',')

    $i      = $t.find 'i'
    kaixin._updateIco $i

    $.post url
