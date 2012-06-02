class Bm.Views.Pagination extends Backbone.View
  template: JST['common/pagination']
  events:
    'click a': 'showPage'

  initialize: (opts) ->
    @update()


  render: ->
    if @pages > 1
      if @pages > 5
        pages = [@current_page - 2, @current_page + 2]
      else
        pages = [1..@pages]
      @$el.html @template
        current_page: @current_page
        last_page: @pages
        pages: pages
    @

  showPage: (event, page) =>
    if event
      event.preventDefault()
      page = $(event.target).attr 'href'
    if page
      @collection.setPage page
      @update()

  update: =>
    @current_page = @collection.getPage()
    @per_page = @collection.getPerPage()
    @collection.getCount (count) =>
      @count = count
      @pages = Math.ceil(parseFloat(@count) / parseFloat(@per_page))
      @render()



