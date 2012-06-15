class Bm.Views.TagBar extends Backbone.View

  template: JST['tags/tag_bar']

  el: '#tag-bar'


  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @appendTag
    @collection.on 'remove', @removeTag

  render: =>

    @$el.html @template tag_count: @collection.size()
    list = @$ 'tbody.tags'
    dropZone = list.children().first()

    @collection.each (tag) =>
      view = new Bm.Views.Tag
        model: tag
        collection: @collection
      dropZone.before view.render().el

    dropZone.droppable
      hoverClass: 'tag-hover'
      drop: (event, ui) =>
        if (@$ '.tag-name').length > 0
          show_alert 'You are already creating a tag!', 'error'
          return
        event.preventDefault()
        new_tag_view = new Bm.Views.NewTag(collection: @collection).render()
        new_tag_view.setBookmark ui.draggable.data 'bookmark'
        dropZone.before new_tag_view.el
        new_tag_view.focus()
        ui.draggable.draggable 'option', 'revert', false

    @collection.each (tag) =>
      tag.off 'selected'
      tag.on 'selected', (tg) =>
        @collection.each (t) =>
          unless t is tg
            t.set 'selected', false, {silent: true}

        @render()

    @

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

