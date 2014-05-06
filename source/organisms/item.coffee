class Atoms.Organism.Item extends Atoms.Organism.Article

  @scaffold "assets/scaffold/item.json"


  # Children bubble events
  onButtonTouch: (event, dispatcher, hierarchy...) ->
    # Your code...

  onLike: (event, dispatcher, hierarchy...) ->
    # Your code...

new Atoms.Organism.Item()
