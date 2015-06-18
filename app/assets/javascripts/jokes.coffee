#= require masonry.pkgd
#= require imagesloaded.pkgd 

$(document).ready ->
  $('.box.grid').imagesLoaded ->

    $('.box.grid').masonry({
      itemSelector: '.grid-item'
      columnWidth: 222
      gutter: 20
    })

  loadingEventFired = false
  currentPage = 1

  $(window).scroll ->
    distanceToFire = 200
    $wrapper = $(document)
    margin = $wrapper.height() - $(window).height() <= $(window).scrollTop()

    if margin and !loadingEventFired
      loadingEventFired = true
      currentPage += 1

      $loader = $('<div class="loading-holder"><i class="kx kx-loading"></i></div>')
      $loader.insertAfter '.box.grid'

      $.get 'hot', { page: currentPage }, (resp) ->
        $loader.remove()

        $items = $(resp).find('.grid-item')
        return if $items.length == 0

        $('.grid').append($items).masonry('appended', $items)
        loadingEventFired = false



