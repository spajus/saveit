class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'tr'
  className: 'bookmark'

  events:
    'click a.link': 'openBookmark'
    'click a.close': 'removeBookmark'

  id: =>
    "bookmark-#{@model.get 'id'}"

  render: ->
    @$el.html @template(bookmark: @model)
    if user_settings.getUseTags
      (@$ '.tags').draggable
        cursor: 'move'
        helper: 'clone'
        revert: true
        start: ->
          ($ '#tag-bar').addClass 'drag-start'
        stop: ->
          ($ '#tag-bar').removeClass 'drag-start'
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
    remove = true
    if user_settings.getConfirmDelete()
      unless confirm "Are you sure you want to delete: '#{@model.get 'title'}'?"
        remove = false
    if remove
      @collection.remove @model
      @model.destroy()

