class Bm.Views.BookmarksIndex extends Backbone.View

  template: JST['bookmarks/index']

  events:
    'submit #new_bookmark': 'createEntry'

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendBookmark

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
      success: -> (@$ '#new_bookmark')[0].reset()
      error: @handleError

  handleError: (bookmark, response) ->
    if response.status is 422
      errors = ($.parseJSON response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

