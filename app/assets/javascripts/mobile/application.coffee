#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require jquery.sticky

$(document).ready ->
  $('.header-nav').sticky(topSpacing: 0)
  $('.header-nav').on 'sticky-start', ->
    $(this).css 'opacity', '0.9'
  $('.header-nav').on 'sticky-end', ->
    $(this).css 'opacity', '1'
