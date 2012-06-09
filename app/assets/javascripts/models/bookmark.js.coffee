class Bm.Models.Bookmark extends Backbone.Model

  bookmarkTypes:
    video: 
      hosts: [
        'youtube'
        'metacafe'
        'vimeo'
      ]
      icon: '<i class="icon-film"></i>'
    photo:
      hosts: [
        'photo'
        'flickr'
        '9gag'
      ]
      icon: '<i class="icon-camera"></i>'
    github:
      hosts: [
        '.*github'
      ]
      icon: '<i class="icon-github"></i>'
    facebook:
      hosts: [
        'facebook'
      ]
      icon: '<i class="icon-facebook-sign"></i>'
    google:
      hosts: [
        'google'
      ]
      icon: '<i class="icon-google-plus"></i>'
    linkedin:
      hosts: [
        'linkedin'
      ]
      icon: '<i class="icon-linkedin-sign"></i>'
    twitter:
      hosts: [
        'twitter'
      ]
      icon: '<i class="icon-twitter"></i>'

  defaultIcon: '<i class="icon-globe"></i>'

  urlRoot: '/api/bookmarks'

  validate: (attrs) ->
    unless attrs.url
      return "url can't be empty!"
    url = attrs.url.toLowerCase()
    unless url.indexOf('http://') is 0
      unless url.indexOf('https://') is 0
        return "url must start with http:// or https://"

  getCreatedAt: ->
    created_at = @get 'created_at'

  getIcon: ->
    url = (@get 'url')
      .toLowerCase()
      .replace(/^.*\/\/(www\.)?/, '')
      .replace(/\/.*/, '')
    for type of @bookmarkTypes
      type = @bookmarkTypes[type]
      for host in type.hosts
        if url.match host
          return type.icon
    return @defaultIcon


