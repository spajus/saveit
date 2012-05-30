class Bm.Views.TagBar extends Backbone.View

  template: JST['tags/tag_bar']

  el: '#tag-bar'


  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendTag
    @collection.on 'remove', @removeTag

  render: =>
    @$el.html @template()
    list = @$ 'tbody.tags'
    dropZone = list.children().first().remove()
    @collection.each (tag) =>
      console.log 'tag', tag
      view = new Bm.Views.Tag
        model: tag
        collection: @collection
      list.append view.render().el
    list.append dropZone
    (@$ '.add-tag-zone').droppable
      hoverClass: 'tag-hover'
      drop: (event, ui) =>
        event.preventDefault()
        new_tag_view = new Bm.Views.NewTag(collection: @collection).render()
        new_tag_view.setBookmark ui.draggable.data 'bookmark'
        ui.draggable.draggable 'option', 'revert', false

  appendTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ 'tbody.tags').prepend view.render().el


  removeTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ '#' + view.id()).remove()

