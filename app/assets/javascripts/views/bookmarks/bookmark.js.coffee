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

    unless @model.get 'visited'
      # We will remove this model from collection and add it again,
      # so list views will refresh themselves
      @collection.remove @model
      @model.set 'visited': true
      @model.save()
      @collection.add @model

  removeBookmark: (event) ->
    @collection.remove @model
    @model.destroy()
