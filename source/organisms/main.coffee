"use strict"

class Atoms.Organism.Main extends Atoms.Organism.Article

  @scaffold "assets/scaffold/main.json"

  fetching: false

  render: ->
    super
    do @__resetPagination
    @context = "today"
    do @fetch

  # ============================================================================
  # Instance Methods
  # ============================================================================
  fetch: (page=0, @category=undefined, destroy = false) ->
    @fetching = true

    unless @category
      @category = __.Entity.Category.all()[0]?.id
      __

    if destroy
      __.Entity.Event.destroyAll()
      do @__resetPagination

    @page[@context] = 0 if page is 0
    @page[@context]++

    parameters =
      started_at: @date[@context]
      page      : @page[@context]
      # latitude  : position.coords.latitude
      # longitude : position.coords.longitude
      # radio     : 100
    parameters.category = @category if @category
    @el.attr "data-category", @category
    background = if parameters.page is 0 then false else true
    KulturKlik.proxy("GET", "search", parameters, background).then (error, response) =>
      events = (__.Entity.Event.create result for result in response.results)
      @[@context].list.entity events, append = true
      @fetching = false if response.results.length is 32
      @[@context].refresh()

  # ============================================================================
  # Children bubble events
  # ============================================================================
  onContext: (event, dispatcher) ->
    @context =  dispatcher.attributes.path.split("/").pop()
    @fetch 0, @category if @page[@context] is 0

  onEvent: (atom, dispatcher, hierarchy...) ->
    __.Article.Event.show atom.entity

  onSectionScroll: (event, dispatcher) ->
    super
    if not @fetching and event.down and (event.height - event.scroll) < 128
      @fetch @page[@context], @category

  # ============================================================================
  # Private Methods
  # ============================================================================
  __resetPagination: ->
    @page =
      today   : 0
      tomorrow: 0
      likes   : 0
    @date =
      today   : moment().format("YYYY/MM/DD")
      tomorrow: moment().add('days', 1).format("YYYY/MM/DD")

new Atoms.Organism.Main()
