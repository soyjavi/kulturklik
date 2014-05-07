"use strict"

class Atoms.Organism.Explorer extends Atoms.Organism.Article

  @scaffold "assets/scaffold/explorer.json"

  page: 0
  fetching: false

  render: ->
    super
    do @fetch

  # Children bubble events
  onEvent: (atom, dispatcher, hierarchy...) ->
    __.Article.Item.fetch atom.entity if atom.entity?

  onSectionScroll: (event, dispatcher, hierarchy...) ->
    super
    if not @fetching and event.down and (event.height - event.scroll) < 128
      @fetch @page

  onSectionPull: (event, dispatcher, hierarchy...) ->
    do @fetch 0

  fetch: (@page=0, @category) ->
    Atoms.Entity.Event.destroyAll() if @page is 0
    @fetching = true

    @page++
    attributes =
      page      : @page
      started_at: "2014/05/07"
    attributes.category = @category if @category
    console.log attributes
    KulturKlik.proxy("GET", "search", attributes).then (error, response) =>
      @today.refresh()
      for result in response.results
        Atoms.Entity.Event.create result
      @fetching = false if response.results.length is 32

new Atoms.Organism.Explorer()
