$(document).ready ->
  $textarea = $('.post-comment textarea')
  $textarea.keyup ->
    content = $.trim $(this).val()
    length = content.length
    $('.limit').find('.size').text length

  $('.post-comment').find('a.btn-success').click ->
    $error = $(this).prev 'span.text-danger'
    content = $.trim $textarea.val()
    if content.length == 0
      $error.text "你还没有输入任何内容哦~"
      return
    else if content.length > 140
      $error.text "最多可以输入140个字符"
      return
    else
      $error.text ''

    joke_id = $('#joke_id').val()

    $.post "/jokes/#{joke_id}/comments", { body: content }, (res) ->
      if res.success?
        $('ul.comments').prepend res.html
        $('.limit').find('.size').text 0
        $textarea.val ''
        $error.text ''
      else
        $error.text res.error
    , 'json'
