class Atoms.Organism.Menu extends Atoms.Organism.Aside

  @scaffold "assets/scaffold/aside.json"

  ALL_LABEL = "Todas"

  render: ->
    super
    KulturKlik.proxy("GET", "categories").then (error, response) =>
      Atoms.Entity.Category.create name: ALL_LABEL
      Atoms.Entity.Category.create category for category in response.categories

  # Children bubble events
  onCategory: (atom, dispatcher, hierarchy...) ->
    category = if atom.entity.id? then atom.entity.id or ""
    __.Article.Explorer.fetch 0, category, destroy = true
    __.Article.Explorer.aside "menu"

    atom.el.addClass("active").siblings().removeClass("active")

new Atoms.Organism.Menu()
