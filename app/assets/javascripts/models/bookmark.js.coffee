class Bm.Models.Bookmark extends Backbone.Model

  ###
    Used to resolve the icon
    if fullUrl is true, hosts are matched to complete url, otherwise only
    hostname part is used, without www
  ###
  bookmarkTypes:
    image:
      fullUrl: true
      hosts: [
        /\.jpe?g$/
        /\.png$/
        /\.gif$/
        /\.bmp$/
      ]
      icon: '<i class="icon-picture"></i>'
    document:
      fullUrl: true
      hosts: [
        /\.pdf$/
        /\.doc$/
        /\.xls$/
        /\.epub$/
      ]
      icon: '<i class="icon-file"></i>'
    audio:
      fullUrl: true
      hosts: [
        /\.mp3$/
        /\.m3u$/
      ]
      icon: '<i class="icon-music"></i>'
    music:
      hosts: [
        'soundcloud'
        'beatport'
        'itunes'
        'last\.fm'
        'discogs'
      ]
      icon: '<i class="icon-music"></i>'
    video:
      hosts: [
        'youtube'
        'metacafe'
        'vimeo'
      ]
      icon: '<i class="icon-film"></i>'
    mail:
      hosts: [
        /^mail\./
      ]
      icon: '<i class="icon-envelope"></i>'
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
    full_url = @get 'url'
    url = full_url
      .toLowerCase()
      .replace(/^.*\/\/(www\.)?/, '')
      .replace(/\/.*/, '')
    for type of @bookmarkTypes
      type = @bookmarkTypes[type]
      match_url = url
      if type.fullUrl
        match_url = full_url
      for host in type.hosts
        if match_url.match host
          return type.icon
    return @defaultIcon


