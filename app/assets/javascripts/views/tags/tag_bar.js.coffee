class Bm.Views.TagBar extends Backbone.View

  template: JST['tags/tag_bar']
  el: '#tag-bar'

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendTag
    @collection.on 'remove', @removeTag

  render: =>
    @$el.html @template()
    (@$ '.add-tag-zone').droppable
      hoverClass: 'tag-hover'
      drop: (event, ui) ->
        ui.draggable.draggable 'option', 'revert', false

        console.log 'drop', event, ui
    list = @$ 'ul.tags'
    @collection.each (tag) =>
      console.log 'tag', tag
      view = new Bm.Views.Tag
        model: tag
        collection: @collection
      list.append view.render().el

  appendTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ 'ul').prepend view.render().el

  removeTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ '#' + view.id()).remove()

