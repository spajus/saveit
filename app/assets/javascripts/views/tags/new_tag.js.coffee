class Bm.Views.NewTag extends Backbone.View

  template: JST['tags/new_tag']
  tagName: 'tr'
  events:
    'keydown': 'processKeypress'
    'click .close': 'cancel'

  processKeypress: (event) ->
    if event.which is 27
      @cancel event
    if event.keyCode is 13
      @createTag event

  initialize: ->
    @model = new Bm.Models.Tag bookmarks_count: 0

  focus: ->
    (@$ '.tag-name').focus()

  render: ->
    @$el.html @template tag: @model
    @

  createTag: (event) =>
    event.preventDefault()
    name = (@$ '.tag-name').val()
    unless name
      @$el.remove()
      show_alert "You must provide a name for your new tag"
      return
    tag_names = @bookmark.get 'tag_names'
    tag_names.push name
    @bookmark.save tags_names: tag_names,
      wait: true
      success: =>
        @$el.remove()
        @collection.fetch()

    show_alert "Succesfully bookmarked <a href='#{@bookmark.get 'url'}'>#{@bookmark.get 'title'}</a> with tag: #{name}", 'success'

  cancel: (event) ->
    event.preventDefault()
    @$el.remove()

  setBookmark: (bookmark) ->
    @bookmark = bookmark
