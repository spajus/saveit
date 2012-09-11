class Bm.Views.Search extends Backbone.View
  el: '#bookmark-search'
  events:
    'keyup': 'processKeyup'

  initialize: (opts) ->
    @collection = opts.collection

  processKeyup: (event) ->
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
    query = decodeURIComponent(query)
    @$el.val query
    @collection.setQuery query
    @collection.fetch()
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
      app.navigate query
    @

  cancel: =>
    @$el.val ''
    @$el.blur()
    @search()
    app.navigate @previous_url or '/'
    @
