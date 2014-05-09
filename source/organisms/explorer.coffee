"use strict"

class Atoms.Organism.Explorer extends Atoms.Organism.Article

  @scaffold "assets/scaffold/explorer.json"

  fetching: false

  page:
    today   : 0
    tomorrow: 0
    likes   : 0

  render: ->
    super
    @context = "today"
    do @fetch

  # Children bubble events
  onContext: (event, dispatcher) ->
    @context =  dispatcher.attributes.path.split("/").pop()
    @fetch 0, @category if @page[@context] is 0

  onEvent: (atom, dispatcher, hierarchy...) ->
    __.Article.Item.fetch atom.entity if atom.entity?

  onSectionScroll: (event, dispatcher, hierarchy...) ->
    if event.scroll > 128
      super
    if not @fetching and event.down and (event.height - event.scroll) < 128
      @fetch @page[@context]

  onSectionPull: (event, dispatcher, hierarchy...) ->
    @fetch 0, @category

  # Private methods
  fetch: (page=0, @category=undefined) ->
    @fetching = true

    date =
      today: moment().format("YYYY/MM/DD")
      tomorrow: moment().add('days', 1).format("YYYY/MM/DD")

    if page is 0
      Atoms.Entity.Event.destroyAll()
      @page[@context] = 0

    @page[@context]++

    parameters =
      started_at: date[@context]
      page      : @page[@context]
      # latitude  : position.coords.latitude
      # longitude : position.coords.longitude
      # radio     : 100
    parameters.category = @category if @category

    console.info @context, @category, parameters

    KulturKlik.proxy("GET", "search", parameters).then (error, response) =>
      @[@context].refresh()
      events = (Atoms.Entity.Event.create result for result in response.results)
      @[@context].list.entity events
      @fetching = false if response.results.length is 32

  __position: ->
    promise = new Hope.promise()
    window.navigator.geolocation.getCurrentPosition (position, error) ->
      promise.done null, latitude: position.coords.latitude, longitude:  position.coords.longitude
    promise

new Atoms.Organism.Explorer()
