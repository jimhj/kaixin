$(document).ready ->
  $('body').on 'keyup', '.post-comment textarea, .fast-comment textarea', ->
    content = $.trim $(this).val()
    length  = content.length
    $limit  = $(this).next('.limit')
    $limit.find('.size').text length

  $('body').on 'click', 'a.postComment', ->
    $error    = $(this).parents('.input-field').next '.error'
    $textarea = $(this).parents('.input-field').find 'textarea'
    content   = $.trim $textarea.val()
    joke_id   = $(this).data 'joke_id'

    if content.length == 0
      $error.text "你还没有输入任何内容哦~"
      return
    else if content.length > 140
      $error.text "最多可以输入140个字符"
      return
    else
      $error.text ''

    $.post "/jokes/#{joke_id}/comments", { body: content }, (res) ->
      if res.success?
        if $('ul.comments').length == 0
          $comments = $('<ul class="comments text-list"></ul>')
          $comments.append res.html
          $('.comment-list .box-content').empty().append $comments
        else
          $('ul.comments').prepend res.html
        $('.limit').find('.size').text 0
        $textarea.val ''
        $error.text ''
      else
        $error.text res.error
    , 'json'

  # 点击加载评论
  $('.joke-item').on 'click', '.operation a.comment.loadComment', ->
    $t        = $(this)
    joke_id   = $t.data 'joke_id'
    url       = "/jokes/#{joke_id}/comments"
    $comments = $t.parents('.operation').next('.box')

    if $comments.length == 1
      if $comments.is(':hidden')
        $comments.slideDown()
      else
        $comments.slideUp()
    else
      $.get url, (res) ->
        $comments = $(res)
        $comments.css 'display', 'none'
        $t.parents('.operation').after $comments
        $comments.slideDown()
        $comments.find('.timeago').timeago()
      , 'html'
