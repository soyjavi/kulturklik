class Atoms.Organism.Item extends Atoms.Organism.Article

  @scaffold "assets/scaffold/item.json"

  # Instance events
  fetch: (@current) ->
    Atoms.Url.path "item/info"
    # Header
    @header.el.attr "class", "c_#{@current.category.id}"
    @header.title.el.html @current.category.name

    # Section
    do @_reset

    @info.image.el.show().css "background-image", "url(#{@current.image})" if @current.image?
    @info.general.title.el.html @current.title

    @info.general.tags.appendChild "Atom.Label", text: @current.type, style: "theme"
    for tag in @current.tags when tag.indexOf(" ") is -1
      @info.general.tags.appendChild "Atom.Label", text: tag


    # @info.general.started_at.el.html @current.started_at
    # @info.general.finished_at.el.html @current.finished_at
    @info.general.address.el.html @current.address
    @info.general.schedule.el.html @current.schedule
    return
    @info.description.el.show().html @current.description if @current.description?
    @info.general.price.el.show().html @current.price if @current.price?

    if @current.position?.length is 2
      @info.map.el.show()
      setTimeout =>
        position = latitude: @current.position[0], longitude: @current.position[1]
        @info.map.clean()
        @info.map.marker position
        @info.map.zoom 15
        @info.map.center position
      , 1000

  # Children bubble events
  onLike: (event, dispatcher, hierarchy...) ->
    # Your code...
    alert "ssksks"

  # Private
  _reset: ->
    @info.image.el.hide()
    @info.general.price.el.hide()
    @info.general.tags.destroyChildren()
    @info.map.el.hide()
    @info.schedule.started_at.el.hide()
    @info.schedule.finished_at.el.hide()

new Atoms.Organism.Item()
