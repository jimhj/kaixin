#= require masonry.pkgd
#= require imagesloaded.pkgd 

$(document).ready ->
  $('.box.grid').imagesLoaded ->
    $('.box.grid').masonry({
      itemSelector: '.grid-item'
      columnWidth: 222
      gutter: 20
    })