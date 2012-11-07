class Bm.Views.Alert extends Backbone.View

  template: JST['common/alert']

  initialize: (content, type='error') ->
    @content = content
    @type = type

  render: ->
    @$el.html @template type: @type, content: @content
    @

  show: (parent='#app-alerts') ->
    ($ parent).prepend @render().el

window.clear_alerts = ->
  ($ '#app-alerts').empty()

window.show_alert = (message, type) ->
  clear_alerts()
  new Bm.Views.Alert(message, type).show()
  setTimeout (-> ($ '#app-alerts').children().fadeOut  -> ($ '#app-alerts').empty()), 5000
