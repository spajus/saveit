String::truncate = (max_length) ->
  if @length > max_length
    "#{@substring(0, max_length)}..."
  else
    @