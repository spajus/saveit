class Bm.Views.ImportExport extends Backbone.View 

  el: '#container'

  template: JST['bookmarks/import_export']

  render: ->
    @$el.html @template

    
    
  
