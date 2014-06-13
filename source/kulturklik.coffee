"use strict"

window.KulturKlik = do ->

  _proxy = (type, method, parameters = {}, background = false) ->
    promise = new Hope.Promise()
    unless background then do __.Modal.Loading.show

    session = __.Article.Session.get()
    token = if session? then session.token else null

    $$.ajax
      url         : "#{__.key.host}#{method}"
      type        : type
      data        : parameters
      contentType : "application/x-www-form-urlencoded"
      dataType    : 'json'
      headers     : "Authorization": token
      success: (response, xhr) ->
        unless background then do __.Modal.Loading.hide
        promise.done null, response
      error: (xhr, error) =>
        unless background then do __.Modal.Loading.hide
        error = code: error.status, message: error.response
        console.error "Atoms.Ide.proxy [ERROR #{error.code}]: #{error.message}"
        promise.done error, null
    promise


  Atoms.$ ->
    if __.Article.Session.get()
      __.Aside.Menu.render().then (error, result) ->
        Atoms.Url.path "main/today"
    else
      Atoms.Url.path "session/appnima"

  proxy     : _proxy
