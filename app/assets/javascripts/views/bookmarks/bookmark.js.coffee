class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'tr'
  className: 'bookmark'

  events:
    'click a.link': 'openBookmark'
    'click a.close': 'removeBookmark'
    'click a.remove': 'removeTag'

  initialize: ->
    @model.on 'change', @renderTags

  id: =>
    "bookmark-#{@model.get 'id'}"

  render: =>
    @$el.html @template(bookmark: @model)
    tag_bar = ($ '#tag-bar')
    if user_settings.getUseTags
      @renderTags()
      dragger = @$ '.dragger'
      dragger.data 'bookmark', @model
      dragger.draggable
        helper: (a, b, c) =>
          (@$ '.drag-tag')
            .clone()
            .show()
            .draggable('option', 'helper')
            .draggable('option', 'revert', true)
        revert: true
        start: =>
          tag_bar.addClass 'drag-start'
          @$el.addClass 'drag-start'
        stop: =>
          tag_bar.removeClass 'drag-start'
          @$el.removeClass 'drag-start'
    @

  renderTags: =>
    # Draw existing tags
    (@$ '.tags').html('&nbsp;')
    taggings = @model.get 'tag_names'
    if taggings.length > 0
      for tagging in taggings
        tag_view = new Bm.Views.BookmarkTag tag: tagging
        (@$ '.tags').append tag_view.render().el

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

  removeTag: (event) =>
    tag_names = @model.get 'tag_names'
    tag = $(event.target).data 'tag'
    for tag_name, i in tag_names
      if tag_name is tag
        tag_names.splice i, 1
    @model.save tag_names: tag_names, {wait: true}
    @collection.trigger 'tags-changed'
    @renderTags()

