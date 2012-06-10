#= require jquery
#= require jquery_ujs
#= require jquery.ui.core
#= require jquery.ui.widget
#= require jquery.ui.mouse
#= require jquery.ui.position
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require jquery.effects.core
#= require jquery.effects.fade
#= require jquery.effects.highlight
#= require bootstrap-all
#= require underscore
#= require backbone
#= require application
#= require_tree ./
#= require sinon

@JST = []
@gon =
  user_settings: []
  current_user:
    id: 1

@server = sinon.fakeServer.create()

@test_bookmarks = []
@test_bookmarks.push new Bm.Models.Bookmark
  id: 1
  title: 'Some title'
  url: 'http://example.com'
  tag_names: ['one', 'two']
  created_at: '1 minute ago'
  visited: false

($ 'body').append '<div id="container"></div>'
