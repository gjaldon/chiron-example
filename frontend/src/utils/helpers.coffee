module.exports =
  animationendEvents: [
    "webkitAnimationEnd"
    "animationend"
    "MSAnimationEnd"
    "oanimationend"
  ]

  template: (name) ->
    @sync_get "/templates/#{name}.html"

  get_data: (url) ->
    url = "#{api_host}/#{url}"
    JSON.parse(@sync_get url).rows?.map (object) ->
      object.value

  toQueryString: (obj) ->
    queryString = ""
    for key, value of obj
      if value then queryString += "#{key}=#{value}&"
    queryString[0..-2]

  sync_put: (url, data) ->
    @sync_request_with_body("PUT", url, data)

  sync_post: (url, data) ->
    @sync_request_with_body("POST", url, data)

  sync_request_with_body: (method, url, data) ->
    request = new XMLHttpRequest()
    params = @toQueryString(data)
    request.open(method, "#{api_host}/#{url}", false)
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    request.send(params)
    request.responseText

  sync_delete: (url, rev) ->
    request = new XMLHttpRequest()
    request.open("DELETE", "#{api_host}/#{url}?rev=#{rev}", false)
    request.send()
    request.responseText

  sync_get: (url) ->
    request = new XMLHttpRequest()
    request.open('GET', url, false)
    request.send()
    request.responseText

  addAnimationEndEvent: (elem, handler) ->
    for event in @animationendEvents
      elem.addEventListener event, handler

  removeAnimationEndEvent: (elem, handler) ->
    for event in @animationendEvents
      elem.removeEventListener event, handler
