class Bm.Views.Tag extends Backbone.View

  template: JST['tags/tag']
  tagName: 'li'
  className: 'tag row-fluid'

  events:
    'click a.close': 'removeTag'

  id: =>
    "tag-#{@model.get 'id'}"

  render: ->
    @$el.html @template tag: @model
    @$el.droppable
      hoverClass: 'tag-hover'
      drop: (event, ui) ->
        ui.draggable.draggable 'option', 'revert', false

        console.log 'drop', event, ui

    @

  removeTag: (event) ->
    remove = true
    if user_settings.getConfirmDelete()
      unless confirm "Are you sure you want to delete tag: '#{@model.get 'name'}'?"
        remove = false
    if remove
      @collection.remove @model
      @model.destroy()

