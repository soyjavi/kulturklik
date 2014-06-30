"use strict"

class Atoms.Organism.Event extends Atoms.Organism.Article

  @scaffold "assets/scaffold/event.json"

  constructor: ->
    super
    do @render

  # ============================================================================
  # Instance Methods
  # ============================================================================
  show: (@entity) ->
    Atoms.Url.path "event/info"
    do @_reset

    # Header
    @el.attr "data-category", @entity.category.id
    # @header.el.attr "class", "category_#{@entity.category.id}"
    @header.category.refresh value: @entity.category.name

    # Image
    if @entity.image
      @info.image.refresh url: @entity.image
    else
      @info.image.refresh url: "http://"

    # General
    @info.summary.title.refresh value: @entity.title
    if @entity.schedule
      @info.summary.extra.schedule.refresh value: @entity.schedule
      @info.summary.extra.schedule.el.show()
    if @entity.price
      @info.summary.extra.price.refresh value: @entity.price
      @info.summary.extra.price.el.show()

    # Tags
    for tag in @entity.tags[1..4] when tag.indexOf(" ") is -1
      @info.tags.appendChild "Atom.Label", value: tag

    # Address
    if @entity.position?.length is 2
      @info.map.el.show()
      setTimeout =>
        position = latitude: @entity.position[0], longitude: @entity.position[1]
        @info.map?.clean()
        @info.map?.center position
        @info.map?.zoom 16
        @info.map?.marker position
      , 500
    @info.summary.address.refresh value: @entity.address

    # Description
    @info.description.el.html @entity.description

  # ============================================================================
  # Private Methods
  # ============================================================================
  _reset: ->
    @info.summary.extra.schedule.el.hide()
    @info.summary.extra.price.el.hide()
    @info.tags.destroyChildren()
    @info.map.el.hide()
    @info.summary.schedule.started_at.el.hide()
    @info.summary.schedule.finished_at.el.hide()

new Atoms.Organism.Event()
