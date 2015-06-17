#= require masonry.pkgd
#= require imagesloaded.pkgd 
#= require jquery.infinitescroll 

$(document).ready ->
  $('.box.grid').imagesLoaded ->
    $('.box.grid').masonry({
      itemSelector: '.grid-item'
      columnWidth: 222
      gutter: 20
    })

  $('.box.grid').infinitescroll({
    debug: true
    navSelector: 'div.header'
    loading: {
      start: ->
        console.log "hahahah"
      finished: ->
        console.log "hehehehe"
    }
    behavior: 'local'
    binder: $(window)
    dataType: 'html'
  }, (html, opts) ->
    console.log 3123123123
  )
