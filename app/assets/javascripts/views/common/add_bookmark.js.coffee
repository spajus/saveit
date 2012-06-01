class Bm.Views.AddBookmark extends Backbone.View

  el: '#add-bookmark'
  template: JST['common/add_bookmark']
  events:
    'submit #add-bookmark': 'createBookmark'

  initialize: (opts) ->
    @inputClass = opts.inputClass

  render: ->
    @$el.html @template inputClass: @inputClass

  createBookmark: (event) ->
    event.preventDefault()
    url = (@$ '#new_bookmark_url').val()
    attrs = title: url, url: url
    @collection.create attrs,
      wait: true
      success: =>
        (@$ '#add-bookmark')[0].reset()
        (@$ '#add-bookmark .control-group').removeClass 'error'
        show_alert "Added new bookmark: <a href='#{url}'>#{url}</a>", 'success'
      error: (object, response) =>
        @handleError '#add-bookmark', object, response

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

