"use strict"

class Atoms.Entity.Event extends Atoms.Class.Entity

  @fields  "id", "title", "description", "image",
           "category", "tags", "type",
           "price",
           "address", "position",
           "started_at", "finished_at", "created_at"

  parse: ->
    image       : @image
    info        : moment(@started_at).startOf('hour').fromNow()
    text        : @title
    description : @category
