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

  search: =>
    query = @$el.val()
    @visited.setQuery query
    @unvisited.setQuery query
    @visited.fetch()
    @unvisited.fetch()

  cancel: =>
    @$el.val ''
    @$el.blur()
    @search()





