class Bm.Views.NewTag extends Backbone.View

  template: JST['tags/new_tag']
  el: '#new-tag'
  events:
    'click .save': 'createTag'

  render: ->
    @$el.html @template()
    @modal = (@$ '#new-tag-modal')
    @modal.modal()
    @modal.on 'hide', =>
      @$el.unbind()
      @$el.empty()
    @

  createTag: (event) =>
    event.preventDefault()
    name = (@$ '#tag-name').val()
    unless name
      @modal.modal 'hide'
      show_alert "You must provide a name for your new tag"
      return
    tag_names = @bookmark.get 'tag_names'
    tag_names.push name
    @bookmark.save tags_names: tag_names, {wait: true}
    @collection.fetch()

    show_alert "Succesfully bookmarked #{@bookmark.get 'title'} with tag: #{name}", 'success'
    @modal.modal 'hide'

  setBookmark: (bookmark) ->
    @bookmark = bookmark
