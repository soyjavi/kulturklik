"use strict"

class Atoms.Entity.Category extends Atoms.Class.Entity

  @fields "name"

  parse: ->
    text        : @name
    style       : @name.toLowerCase().split(" ")[0]
