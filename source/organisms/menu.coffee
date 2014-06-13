"use strict"

class Atoms.Organism.Menu extends Atoms.Organism.Aside

  @scaffold "assets/scaffold/menu.json"

  ALL_LABEL = "Todas"
  UNALVAILABLE_CATEGORIES = ["artes visuales", "museos"]

  render: ->
    super
    promise = new Hope.Promise()
    KulturKlik.proxy("GET", "categories").then (error, response) =>
      __.Entity.Category.create name: ALL_LABEL
      for category in response.categories when category.name.toLowerCase() not in UNALVAILABLE_CATEGORIES
        __.Entity.Category.create category
      promise.done null, true
    promise

  # Children bubble events
  onCategory: (atom, dispatcher, hierarchy...) ->
    category = if atom.entity.id? then atom.entity.id or ""
    __.Article.Main.fetch 0, category, destroy = true
    __.Article.Main.aside @attributes.id
    atom.el.addClass("active").siblings().removeClass("active")


new Atoms.Organism.Menu()
