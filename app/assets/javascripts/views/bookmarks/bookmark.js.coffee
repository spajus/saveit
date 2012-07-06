class Bm.Views.Bookmark extends Backbone.View

  template: JST['bookmarks/bookmark']
  tagName: 'tr'
  className: 'bookmark'

  events:
    'click a.link': 'openBookmark'
    'click a.close': 'removeBookmark'
    'click a.remove': 'removeTag'

  initialize: ->
    @model.on 'change',  @renderTags

  id: =>
    "bookmark-#{@model.get 'id'}"

  previewUrl: =>
    "#{gon.preview_url}?url=#{encodeURIComponent(@model.get 'url')}"

  render: =>
    @$el.html @template bookmark: @model
    tag_bar = ($ '#tag-bar')

    # preload thumbnail so it will exist later on
    $.get @previewUrl()
    placement = 'right'
    if @model.get 'visited'
      placement = 'left'

    (@$ 'a.link').popover
      placement: placement
      content: "<img src=\"#{@previewUrl()}\"/>"
      delay:
        show: 500
        hide: 50

    if user_settings.getUseTags
      @renderTags()
      elem = @$el
      model_visited = @model.get 'visited'
      dragger = @$ '.dragger'
      dragger.data 'bookmark', @model
      dragger.draggable
        helper: (event) =>
          (@$ '.drag-tag')
            .clone()
            .show()
            .width(200)
            .draggable('option', 'helper')
            .draggable('option', 'revert', true)
        revert: true
        distance: 10
        cursorAt:
          left: 100
          top: 20
        containment: 'document'

        start: (event, ui) ->
          ($ ui.helper).animate opacity: 0.7
          tag_bar.addClass 'drag-start'
          elem.addClass 'drag-start'
          if model_visited
            ($ '#bookmarks-unread table').addClass 'drag-start'
          else
            ($ '#bookmarks-read table').addClass 'drag-start'

        stop: (event, ui) ->
          tag_bar.removeClass 'drag-start'
          elem.removeClass 'drag-start'
          ($ '#bookmarks-unread table').removeClass 'drag-start'
          ($ '#bookmarks-read table').removeClass 'drag-start'
    @

  renderTags: =>
    # Draw existing tags
    (@$ '.tags').html('&nbsp;')
    taggings = @model.get 'tag_names'
    if taggings?.length > 0
      for tagging in taggings
        tag_view = new Bm.Views.BookmarkTag tag: tagging
        (@$ '.tags').append tag_view.render().el

  openBookmark: (event) ->
    event.preventDefault()
    visited = @model.get 'visited'
    unless visited
      @model.set 'visited', true
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
    event.preventDefault()
    tag_names = @model.get 'tag_names'
    tag = $(event.target).data 'tag'
    remove = true
    if user_settings.getConfirmDelete()
      unless confirm "Are you sure you want to remove tag: '#{tag}'?"
        remove = false
    unless remove
      return
    for tag_name, i in tag_names
      if tag_name is tag.toString()
        tag_names.splice i, 1
    @model.save tag_names: tag_names,
      wait: true
      success: =>
        @collection.trigger 'tags-changed'
        @renderTags()

