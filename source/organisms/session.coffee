class Atoms.Organism.Session extends Atoms.Organism.Article

  @scaffold "assets/scaffold/session.json"

  render: ->
    super
    Appnima.key = __.key.appnima

  # Instance methods
  get: ->
    Appnima.User.session()

  # Children bubble events
  onSuccess: (event) ->
    console.log "onSuccess", event
    Atoms.Url.path "main/today"

  onAppnimaSessionError: (event, dispatcher, hierarchy...) ->
    console.log "onAppnimaSessionError", event

new Atoms.Organism.Session()
