class Bm.Views.BookmarksIndex extends Backbone.View

  el: '#container'

  events:
    'submit #new_bookmark': 'createBookmark'
    'submit #new_tag': 'createTag'

  template: ->
    if user_settings.getUseTags()
      JST['bookmarks/index_with_tags']
    else
      JST['bookmarks/index']


  initialize: ->

    @unvisited_collection = new Bm.Collections.UnvisitedBookmarks()
    @unvisited_collection.reset gon.unvisited_bookmarks
    @unvisited_collection.on 'open-bookmark', @openBookmark

    @visited_collection = new Bm.Collections.VisitedBookmarks()
    @visited_collection.reset gon.visited_bookmarks
    @visited_collection.on 'open-bookmark', @openBookmark

    @tag_collection = new Bm.Collections.Tags()
    @tag_collection.reset gon.user_tags or []

    window.collections = [@unvisited_collection, @visited_collection, @tag_collection]

    user_settings.on 'change', @render

  render: =>

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

    @bookmarklet.render()
    @bookmarks_read.render()
    @bookmarks_unread.render()
    @tagBar.render() if user_settings.getUseTags()
    @

  createBookmark: (event) ->
    event.preventDefault()
    url = (@$ '#new_bookmark_url').val()
    attrs = title: url, url: url
    @unvisited_collection.create attrs,
      wait: true
      success: ->
        (@$ '#new_bookmark')[0].reset()
        (@$ '#new_bookmark .control-group').removeClass 'error'
        show_alert "Added new bookmark: <a href='#{url}'>#{url}</a>", 'success'
      error: (object, response) =>
        @handleError '#new_bookmark', object, response

  createTag: (event) ->
    event.preventDefault()
    name = (@$ '#new_tag_name').val()
    attrs = name: name
    @tag_collection.create attrs,
      wait: true
      success: ->
        (@$ '#new_tag')[0].reset()
        (@$ '#new_bookmark .control-group').removeClass 'error'
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




