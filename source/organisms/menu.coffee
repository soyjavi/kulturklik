class Atoms.Organism.Menu extends Atoms.Organism.Aside

  @scaffold "assets/scaffold/menu.json"

  ALL_LABEL = "Todas"

  render: ->
    super
    KulturKlik.proxy("GET", "categories").then (error, response) =>
      Atoms.Entity.Category.create name: ALL_LABEL
      Atoms.Entity.Category.create name: category for category in response.categories

  # Children bubble events
  onCategory: (atom, dispatcher, hierarchy...) ->
    category = if atom.entity.name isnt ALL_LABEL then atom.entity.name or ""
    __.Article.Explorer.fetch 0, category
    __.Article.Explorer.aside "menu"

    atom.el.addClass("active").siblings().removeClass("active")

new Atoms.Organism.Menu()
