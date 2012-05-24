class Bm.Views.BookmarksIndex extends Backbone.View

  template: JST['bookmarks/index']

  events:
    'submit #new_bookmark': 'createEntry'

  initialize: ->
    @unvisited_collection = new Bm.Collections.UnvisitedBookmarks()
    @visited_collection = new Bm.Collections.VisitedBookmarks()
    @unvisited_collection.reset(($ '#container').data 'unvisited-bookmarks')
    @visited_collection.reset(($ '#container').data 'visited-bookmarks')
    @unvisited_collection.on 'open-bookmark', @openBookmark
    @visited_collection.on 'open-bookmark', @openBookmark

    @bookmarks_read = new Bm.Views.BookmarksList
      collection: @visited_collection
      title: 'Archive'
      visited: true
    @bookmarks_unread = new Bm.Views.BookmarksList
      collection: @unvisited_collection
      title: 'Fresh'
      visited: false
    @bookmarklet = new Bm.Views.Bookmarklet()

  render: ->
    @$el.html @template()
    (@$ '#bookmarklet').html @bookmarklet.render().el
    (@$ '#bookmarks-read').html @bookmarks_read.render().el
    (@$ '#bookmarks-unread').html @bookmarks_unread.render().el
    @

  createEntry: (event) ->
    event.preventDefault()
    url = (@$ '#new_bookmark_url').val()
    attrs = title: url, url: url
    @unvisited_collection.create attrs,
      wait: true
      success: ->
        (@$ '#new_bookmark')[0].reset()
        (@$ '#new_bookmark .control-group').removeClass 'error'
        (@$ '#new_bookmark_help').empty()
      error: @handleError

  handleError: (bookmark, response) =>
    error_msg = ""
    if response.status is 422
      errors = ($.parseJSON response.responseText).errors
      for attribute, messages of errors
        error_msg += "#{attribute} #{message}" for message in messages
    else
      error_msg = response
    (@$ '#new_bookmark .control-group').addClass 'error'
    (@$ '#new_bookmark_help').text error_msg

  openBookmark: (bookmark, options) =>
    unless options.visited
      @unvisited_collection.remove bookmark
      @visited_collection.add bookmark
    window.location.assign bookmark.get 'url'




