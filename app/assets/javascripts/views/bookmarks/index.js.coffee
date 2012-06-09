class Bm.Views.BookmarksIndex extends Backbone.View

  el: '#container'

  events:
    'submit #new_tag': 'createTag'

  template: ->
    if user_settings.getUseTags()
      JST['bookmarks/index_with_tags']
    else
      JST['bookmarks/index']


  initialize: (opts) ->
    @tag_collection = new Bm.Collections.Tags()
    @unvisited_collection = new Bm.Collections.Bookmarks visited: false
    @visited_collection = new Bm.Collections.Bookmarks visited: true

    tag = opts.tag
    if user_settings.getUseTags() and tag
      @tag_collection.setSelectedTag tag
      @unvisited_collection.setSelectedTag tag
      @visited_collection.setSelectedTag tag


    @tag_collection.reset gon.user_tags or []
    @tag_collection.on 'remove', =>
      @unvisited_collection.fetch()
      @visited_collection.fetch()

    @unvisited_collection.reset gon.unvisited_bookmarks, cleanup: true
    @visited_collection.reset gon.visited_bookmarks, cleanup: true

    @unvisited_collection.on 'open-bookmark', @openBookmark
    @visited_collection.on 'open-bookmark', @openBookmark

    @unvisited_collection.on 'tags-changed', =>
      @tag_collection.fetch()

    @visited_collection.on 'tags-changed', =>
      @tag_collection.fetch()


    window.collections = [@unvisited_collection, @visited_collection, @tag_collection]

    user_settings.on 'change', @render

    search = new Bm.Views.Search
      unvisited: @unvisited_collection,
      visited: @visited_collection


  showTag: (tag) =>
    @unvisited_collection.setSelectedTag tag
    @visited_collection.setSelectedTag tag
    @unvisited_collection.fetch()
    @visited_collection.fetch()

  render: =>

    # If settings were changed along with page size, we have to make sure
    # that collections are refetched
    @unvisited_collection.updatePageSize user_settings.getPageSize()
    @visited_collection.updatePageSize user_settings.getPageSize()

    @$el.html @template()

    @bookmarklet = new Bm.Views.Bookmarklet el: '#bookmarklet'

    @bookmarks_read = new Bm.Views.BookmarksList
      el: '#bookmarks-read'
      collection: @visited_collection
      title: 'Archive'
      visited: true

    @bookmarks_unread = new Bm.Views.BookmarksList
      el: '#bookmarks-unread'
      collection: @unvisited_collection
      title: 'Fresh'
      visited: false

    if user_settings.getUseTags()
      @tagBar = new Bm.Views.TagBar
        collection: @tag_collection
      inputClass = 'span3'
    else
      inputClass = 'span4'

    @add_bookmark = new Bm.Views.AddBookmark
      inputClass: inputClass #inputClass controls width of bookmark input
      collection: @unvisited_collection

    @add_bookmark.render()
    @bookmarklet.render()
    @bookmarks_read.render()
    @bookmarks_unread.render()

    @tagBar.render() if user_settings.getUseTags()
    @


  createTag: (event) ->
    event.preventDefault()
    name = (@$ '#new_tag_name').val()
    attrs = name: name
    @tag_collection.create attrs,
      wait: true
      success: ->
        (@$ '#new_tag')[0].reset()
        (@$ '#new_tag .control-group').removeClass 'error'
        show_alert "Added new tag: #{name}", 'success'
      error: (object, response) =>
        @handleError '#new_tag', object, response


    attrs = name: $


  handleError: (source, object, response) =>
    error_msg = ""
    if response.status is 422
      errors = ($.parseJSON response.responseText).errors
      for attribute, messages of errors
        error_msg += "#{attribute} #{message}" for message in messages
    else
      error_msg = response
    (@$ "#{source} .control-group").addClass 'error'
    show_alert error_msg

  openBookmark: (bookmark, options) =>
    unless options.visited
      @unvisited_collection.remove bookmark
      @visited_collection.add bookmark

    if user_settings.getLinkTarget() is 'same'
      window.location.assign bookmark.get 'url'
    else
      window.open(bookmark.get 'url', '_blank')




