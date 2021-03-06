#= require jquery
#= require jquery_ujs
#= require jquery.placeholder 
#= require cookies
#= require jquery.timeago
#= require jquery.timeago.zh-CN
#= require jquery.sticky
#= require kaixin
#= require comments
#= require votings
#= require html5media.min
#= require_self

$(document).ready ->
  $('input, textarea').placeholder()
  $('.timeago').timeago()

  $('body').on 'mouseenter', '.login', ->
    $(this).find('ul.menu').slideDown('fast')
  .on 'mouseleave', '.login', ->
    $(this).find('ul.menu').slideUp()

  $.get '/login_state', (res) ->
    $('.right.links').replaceWith(res)
  , 'html'

  $('.stickAd').sticky
    topSpacing: 0    
    bottomSpacing: 300

  $('.search .kx-zoom').click ->
    $(this).parent()[0].submit()
