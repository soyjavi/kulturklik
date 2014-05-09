Atoms.$ ->
  session = __.Article.Session.get()
  session = true
  if session
    __.Aside.Menu.render()
    Atoms.Url.path "explorer/today"
  else
    Atoms.Url.path "session/appnima"

window.KulturKlik = do ->

  STORAGE_KEY = "kulturklik"

  _proxy = (type, method, parameters = {}, background = false) ->
    promise = new Hope.Promise()
    unless background then do __.Modal.Loading.show

    session = __.Article.Session.get()
    token = if session? then session.token else null

    $$.ajax
      # url         : "http://devcast.co/culture/#{method}"
      url         : "http://192.168.1.129:1337/culture/#{method}"
      type        : type
      data        : parameters
      contentType : "application/x-www-form-urlencoded"
      dataType    : 'json'
      headers     : "Authorization": token
      success: (xhr) ->
        unless background then do __.Modal.Loading.hide
        promise.done null, JSON.parse(xhr.responseText)
      error: (xhr, error) =>
        unless background then do __.Modal.Loading.hide
        error = code: error.status, message: error.response
        console.error "Atoms.Ide.proxy [ERROR #{error.code}]: #{error.message}"
        promise.done error, null
    promise

  proxy     : _proxy
