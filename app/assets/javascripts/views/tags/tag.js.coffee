class Bm.Views.Tag extends Backbone.View

  template: JST['tags/tag']
  tagName: 'tr'

  events:
    'click a.close': 'removeTag'

  id: =>
    "tag-#{@model.get 'id'}"

  render: ->
    @$el.html @template(tag: @model)
    @

  removeTag: (event) ->
    remove = true
    if user_settings.getConfirmDelete()
      unless confirm "Are you sure you want to delete tag: '#{@model.get 'name'}'?"
        remove = false
    if remove
      @collection.remove @model
      @model.destroy()

