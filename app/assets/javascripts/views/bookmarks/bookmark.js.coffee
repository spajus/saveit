class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'tr'

  events:
    'click a.link': 'openBookmark'
    'click a.close': 'removeBookmark'

  id: =>
    "bookmark-#{@model.get 'id'}"

  render: ->
    @$el.html @template(bookmark: @model)
    @

  openBookmark: (event) ->
    event.preventDefault()
    visited = @model.get 'visited'
    unless visited
      # We will remove this model from collection and add it again,
      # so list views will refresh themselves
      @model.set 'visited': true
      @model.save()
    @collection.trigger 'open-bookmark', @model, visited: visited

  removeBookmark: (event) ->
    if confirm "Are you sure you want to delete: '#{@model.get 'title'}'?"
      @collection.remove @model
      @model.destroy()
