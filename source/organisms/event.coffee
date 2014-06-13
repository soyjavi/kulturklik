"use strict"

class Atoms.Organism.Event extends Atoms.Organism.Article

  @scaffold "assets/scaffold/event.json"

  # Instance Events
  show: (@entity) ->
    Atoms.Url.path "event/info"
    do @_reset

    # Header
    @el.attr "data-category", @entity.category.id
    # @header.el.attr "class", "category_#{@entity.category.id}"
    @header.category.refresh text: @entity.category.name

    # Image
    if @entity.image
      @info.image.refresh url: @entity.image
      @info.image.el.show()

    # General
    @info.title.refresh text: @entity.title
    if @entity.schedule
      @info.extra.schedule.refresh text: @entity.schedule
      @info.extra.schedule.el.show()
    if @entity.price
      @info.extra.price.refresh text: @entity.price
      @info.extra.price.el.show()

    # Tags
    for tag in @entity.tags[1..4] when tag.indexOf(" ") is -1
      @info.tags.appendChild "Atom.Label", text: tag

    # Address
    if @entity.position?.length is 2
      @info.map.el.show()
      setTimeout =>
        position = latitude: @entity.position[0], longitude: @entity.position[1]
        @info.map.marker position
        @info.map.clean()
        @info.map.zoom 15
        @info.map.center position
      , 1000
    @info.address.refresh value: @entity.address

    # Description
    @info.description.el.html @entity.description

  # Private
  _reset: ->
    @info.image.el.hide()
    @info.extra.schedule.el.hide()
    @info.extra.price.el.hide()
    @info.tags.destroyChildren()
    @info.map.el.hide()
    @info.schedule.started_at.el.hide()
    @info.schedule.finished_at.el.hide()

new Atoms.Organism.Event()
