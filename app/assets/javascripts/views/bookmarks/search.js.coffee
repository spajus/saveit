class Bm.Views.Search extends Backbone.View
  el: '#bookmark-search'
  events:
    'keydown': 'processKeydown'

  initialize: (opts) ->
    @visited = opts.visited
    @unvisited = opts.unvisited

  processKeydown: (event) ->
    if event.which is 27
      event.preventDefault()
      @cancel()
    else if event.keyCode is 13
      event.preventDefault()
      @search()
    else
      @searchTimeout()

  searchTimeout: =>
    if @searchTimer
      clearTimeout @searchTimer
    @searchTimer = setTimeout @search, 300

  loadSearch: (q) ->
    @$el.val q
    @search()
    @$el.focus()


  search: =>
    query = @$el.val()
    query = query.replace(/^\s+/, '').replace /\s+$/, ''
    @visited.setQuery query
    @unvisited.setQuery query
    @visited.fetch()
    @unvisited.fetch()
    unless query
      # cant @search() to avoid loop
      @$el.val ''
      @$el.blur()
      app.navigate @previous_url or '/'
      return @
    pathname = window.location.pathname
    unless pathname.match /^\/search/
      @previous_url = pathname
    query = "/search/#{encodeURIComponent(query)}"
    if pathname isnt query
      #if $.cookie 'search-installed'
      app.navigate query
      #else
      #  $.cookie 'search-installed', true, expires: 365
      #  window.location.assign query
    @

  cancel: =>
    @$el.val ''
    @$el.blur()
    @search()
    app.navigate @previous_url or '/'
    @
