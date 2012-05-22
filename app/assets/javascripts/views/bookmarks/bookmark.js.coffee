class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'li'

  events:
    'click a.link': 'openBookmark'

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
