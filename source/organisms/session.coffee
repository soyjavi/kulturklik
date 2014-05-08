class Atoms.Organism.Session extends Atoms.Organism.Article

  @scaffold "assets/scaffold/session.json"

  STORAGE_KEY = "kulturklik"

  constructor: ->
    super
    Appnima.key = "NTM2YTZlZWYxZWFkMTZjMzQzOWE1NzM3OkljbjRFRHdiQ252b0JkdXBxdThvdHpiV2phbVRpOG8="

  # Instance Methods
  get: ->
    JSON.parse localStorage.getItem STORAGE_KEY

  set: (session) ->
    localStorage.setItem STORAGE_KEY, JSON.stringify(session)

  logout: ->
    window.localStorage.removeItem STORAGE_KEY

  # Children Bubble Events
  onLogin: (event, dispatcher, hierarchy...) ->
    console.log "onLogin", arguments

  onSignup: (event, dispatcher, hierarchy...) ->
    console.log "onSignup", arguments

  onError: (event, dispatcher, hierarchy...) ->
    console.log "onError", arguments


new Atoms.Organism.Session()
