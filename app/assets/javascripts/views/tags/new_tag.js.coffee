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
<<<<<<< Updated upstream
    new_tag = new Bm.Models.Tag
      name: name
      bookmarks:
        count: 1
    new_tag.save wait: true
    @collection.add new_tag
    taggings = @bookmark.get('taggings') or []
    tagging =
      bookmark_id: @bookmark.get 'id'
      tag_id: new_tag.get 'id'
      tag_name: new_tag.get 'name'
    taggings.push tagging
    @bookmark.save taggings: taggings
=======
    #new_tag = new Bm.Models.Tag name: name
    #new_tag.save wait: true
    #@collection.add new_tag
    #taggings = @bookmark.get('taggings') or []
    #tagging =
    #  bookmark_id: @bookmark.get 'id'
    #  tag_id: new_tag.get 'id'
    #  tag_name: new_tag.get 'name'
    #taggings.push tagging
    tags = @bookmark.get 'tag_names'
    tags.push name

    @bookmark.save tags: tags
>>>>>>> Stashed changes
    show_alert "Succesfully bookmarked #{@bookmark.get 'title'} with tag: #{name}", 'success'
    @modal.modal 'hide'

  setBookmark: (bookmark) ->
    @bookmark = bookmark
