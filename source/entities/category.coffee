"use strict"

class __.Entity.Category extends Atoms.Class.Entity

  @fields "id", "name", "count"

  parse: ->
    text        : @name
    info        : @count
    style       : "category_#{@id}"
