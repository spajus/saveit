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
@server.autoRespond = true

@test_bookmarks =
  example_com: new Bm.Models.Bookmark
    id: 1
    title: 'Some title'
    url: 'http://example.com'
    tag_names: ['one', 'two']
    created_at: '1 minute ago'
    visited: false
  spy_link: new Bm.Models.Bookmark
    id: 2
    title: 'Open me from javascript'
    url: 'http://fake.url'
    created_at: '2 minutes ago'
    visited: false

@random_int = (stop=10) ->
  Math.floor Math.random() * (stop + 1)


@generate_bookmarks = (count, visited=false) ->
  bookmarks = []
  rand = @random_int 1000
  tag_count = @random_int 5
  for x in [1..count]
    id = rand + x
    bookmark = new Bm.Models.Bookmark
      id: id
      title: "Bookmark ##{id}"
      url: "http://example.com/#{id}"
      tag_names: @generate_bookmark_tags tag_count
      created_at: "#{x} minutes ago"
      visited: visited

@generate_bookmark_tags = (count, prefix='tag') ->
  tags = []
  for x in [1..count]
    tags.push "#{prefix}#{x}"
  tags

@generate_tags = (count, prefix='tag') ->
  tags = []
  for x in [1..count]
    tag = new Bm.Models.Tag
      id: x
      name: "#{prefix}#{x}"
      bookmarks_count: @random_int 20

$ ->
  ($ 'body').append '<div id="container"></div>'
