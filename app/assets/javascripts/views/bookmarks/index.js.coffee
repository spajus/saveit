class Bm.Views.BookmarksIndex extends Backbone.View

  template: JST['bookmarks/index']

  events:
    'submit #new_bookmark': 'createEntry'

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendBookmark
    @collection.on 'error', @handleError

  render: =>
    @$el.html @template()
    @collection.each @appendBookmark
    @

  appendBookmark: (bookmark) =>
    view = new Bm.Views.Bookmark(model: bookmark)
    (@$ '#bookmarks').append view.render().el

  createEntry: (event) ->
    event.preventDefault()
    url = (@$ '#new_bookmark_url').val()
    attrs = title: url, url: url
    @collection.create attrs,
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




