"use strict"

class Atoms.Entity.Event extends Atoms.Class.Entity

  @fields  "id", "title", "description", "image",
           "category", "tags", "type",
           "price",
           "address", "position",
           "started_at", "finished_at", "schedule", "created_at"

  parse: ->
    image       : @image
    info        :  if value? and value.substr(2, 1) is ":" then value.substr(0,5) else ""
    text        : @title
    description : @address
    style       : "category_#{@category.id}"
