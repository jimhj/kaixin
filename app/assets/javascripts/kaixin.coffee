@kaixin = {}
@kaixin.cookies = Cookies
@kaixin.compact = (arr) ->
  new_arr = new Array()
  for i in arr
    new_arr.push i if i
  new_arr