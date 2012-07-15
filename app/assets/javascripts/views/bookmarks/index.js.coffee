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
    @collection = new Bm.Collections.Bookmarks()

    tag = opts.tag
    if user_settings.getUseTags() and tag
      @tag_collection.setSelectedTag tag
      @collection.setSelectedTag tag


    @tag_collection.reset gon.user_tags or []
    @tag_collection.on 'remove', =>
      @collection.fetch()

    @collection.reset gon.bookmarks, cleanup: true
    @collection.on 'open-bookmark', @openBookmark
    @collection.on 'tags-changed', => @tag_collection.fetch()

    window.collections = [@collection, @tag_collection]

    search = new Bm.Views.Search
      collection: @collection

    if opts.search_query
      search.loadSearch opts.search_query


  showTag: (tag) =>
    @collection.setSelectedTag tag
    @collection.fetch()

  render: =>

    # If settings were changed along with page size, we have to make sure
    # that collections are refetched
    @collection.updatePageSize user_settings.getPageSize()

    @$el.html @template()

    @bookmarklet = new Bm.Views.Bookmarklet el: '#bookmarklet'

    @bookmarks = new Bm.Views.BookmarksList
      el: '#bookmarks'
      collection: @collection

    if user_settings.getUseTags()
      @tagBar = new Bm.Views.TagBar
        collection: @tag_collection
      @tagBar.render()
      inputClass = 'span3'
    else
      inputClass = 'span4'

    @add_bookmark = new Bm.Views.AddBookmark
      inputClass: inputClass #inputClass controls width of bookmark input
      collection: @collection

    @add_bookmark.render()
    @bookmarklet.render()
    @bookmarks.render()
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
    if user_settings.getLinkTarget() is 'same'
      window.location.assign bookmark.get 'url'
    else
      window.open(bookmark.get 'url', '_blank')

