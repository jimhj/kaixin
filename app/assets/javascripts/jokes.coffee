# #= require masonry.pkgd
# #= require imagesloaded.pkgd 

# $(document).ready ->
#   $loader = $('<div class="loading-holder"><i class="kx kx-loading"></i></div>')
#   loadingEventFired = true
#   currentPage = 1
#   $grid = null

#   $('.main').prepend $loader

#   $('.box.grid').imagesLoaded ->
#     $grid = $('.box.grid').masonry({
#       itemSelector: '.grid-item'
#       columnWidth: 222
#       gutter: 20
#     })

#     $('.box.grid').css('visibility', 'visible')
#     $loader.hide()
#     loadingEventFired = false     

#   $(window).scroll ->
#     distanceToFire = 200
#     $wrapper = $(document)
#     margin = $wrapper.height() - $(window).height() <= $(window).scrollTop()

#     if margin and !loadingEventFired
#       loadingEventFired = true
#       currentPage += 1

#       $loader.insertAfter '.box.grid'
#       $loader.show()

#       $.get 'hot', { page: currentPage }, (resp) ->
#         $items = $(resp).find('.grid-item')

#         if $items.length == 0
#           $loader.hide()
#           return
        
#         $ad_items = $('.grid').find('.adHolder').clone()
#         $ad_items.removeClass('adHolder')

#         $items.imagesLoaded -> 
#           $grid.append($ad_items).masonry('appended', $ad_items).masonry('stamp', $ad_items)
#           $grid.append($items).masonry('appended', $items).masonry('stamp', $items)

#           loadingEventFired = false
#           $loader.hide()




