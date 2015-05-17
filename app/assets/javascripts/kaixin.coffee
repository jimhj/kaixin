@kaixin = {}
@kaixin.cookies = Cookies
@kaixin.compact = (arr) ->
  arr.filter (e) ->
    e.replace /(\r\n|\n|\r)/gm, ''
