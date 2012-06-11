class Bm.Collections.Bookmarks extends Backbone.Collection

  model: Bm.Models.Bookmark
  url: '/api/bookmarks'

  initialize: (opts) ->
    @visited = opts.visited or false
    @page = opts.page or 1
    @per_page = opts.per_page or user_settings.getPageSize()

  setPage: (page) =>
    @page = parseInt(page)
    @fetch()
    @

  getPage: =>
    @page

  getPerPage: =>
    @per_page

  updatePageSize: (page_size) =>
    unless @per_page is page_size
      @page = 1
      @per_page = page_size
      @fetch()

  getCount: (callback) =>
    count_req = @fetch data:
      count: true
    ,
      wait: true
      silent: true
    count_req.success (count) =>
      callback count

  setSelectedTag: (tag) ->
    if tag
      @tag = tag.replace /\-/g, ' '
    else
      @tag = null

  setQuery: (query) ->
    @query = query


  reset: (data, options) =>
    if data is @models
      return false
    if options?.cleanup and @tag
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

  # This handles processing @getCount call, otherwise models would break
  parse: (opts) =>
    if _.isArray opts
      super opts
    else
      return @models

  # Builds query string for this collection accorting to its state
  _buildFetchParams: (initial={}) =>
    data = initial.data or {}
    data.tag = @tag if @tag
    data.query = @query if @query
    data.visited = @visited
    data.page = @page
    data.per_page = @per_page
    initial.data = data
    initial
