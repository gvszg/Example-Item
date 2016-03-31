jQuery ->
  $("#items").sortable
    axis: "y"
    handle: ".handle"
    update: ->
      $.post($(this).data("update-url"), $(this).sortable("serialize"))
      # $("#item-<%= item.id %>-position").html("<%= item.position %>")