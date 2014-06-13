"use strict"

class __.Entity.Event extends Atoms.Class.Entity

  @fields  "id", "title", "description", "image",
           "category", "tags", "type",
           "price",
           "address", "position",
           "started_at", "finished_at", "schedule", "created_at"

  parse: ->
    image       : @image
    text        : @title
    description : @address
    info        : __schedule @schedule
    style       : "category_#{@category.id}"

__schedule = (value) ->
  if value? and value.substr(2, 1) is ":" then value.substr(0,5) else ""

