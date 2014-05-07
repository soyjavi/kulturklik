class Atoms.Organism.Item extends Atoms.Organism.Article

  @scaffold "assets/scaffold/item.json"

  # Instance events
  fetch: (@current) ->
    Atoms.Url.path "item/info"

    if @current.image?
      @info.image.el.show().css "background-image", "url(#{@current.image})"
    else
      @info.image.el.hide()
    @info.title.el.html @current.title
    @info.description.el.html @current.description

    setTimeout =>
      position = latitude: @current.position[0], longitude: @current.position[1]
      @info.map.marker position
      @info.map.center position
      @info.map.zoom 15
    , 1000

    console.log @current

  # Children bubble events
  onLike: (event, dispatcher, hierarchy...) ->
    # Your code...
    alert "ssksks"

new Atoms.Organism.Item()
