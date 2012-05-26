class Bm.Views.TagBar extends Backbone.View

  template: JST['tags/tag_bar']
  el: '#tag-bar'

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendTag
    @collection.on 'remove', @removeTag

  render: =>
    @$el.html @template()
    list = @$ 'tbody'
    @collection.each (tag) =>
      view = new Bm.Views.Tag
        model: tag
        collection: @collection
      list.append view.render().el

  appendTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ 'tbody').prepend view.render().el

  removeTag: (tag) =>
    view = new Bm.Views.Tag
      model: tag
      collection: @collection
    (@$ '#' + view.id()).remove()

