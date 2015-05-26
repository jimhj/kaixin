#= require jquery
#= require jquery_ujs
#= require jquery.placeholder 
#= require cookies
#= require jquery.timeago
#= require jquery.timeago.zh-CN
#= require kaixin
#= require comments
#= require votings
#= require_self

$(document).ready ->
  $('input, textarea').placeholder()
  $('.timeago').timeago()