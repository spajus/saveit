class Bm.Collections.Bookmarks extends Backbone.Collection

  model: Bm.Models.Bookmark
  url: '/api/bookmarks'

  initialize: (opts) ->
    @visited = opts.visited or false

  setSelectedTag: (tag) ->
    if tag
      @tag = tag.replace /\-/g, ' '
    else
      @tag = null

  reset: (data, options) =>
    if options.cleanup and @tag
      cleansed = []
      for datum in data
        for tag in datum.tag_names
          if tag is @tag
            cleansed.push datum
            break
      data = cleansed
    super data

  fetch: (opts) =>
    super @_buildFetchParams opts

  _buildFetchParams: (initial={}) =>
    data = initial.data or {}
    if @tag
      data.tag = @tag
    data.visited = @visited
    initial.data = data
    initial
