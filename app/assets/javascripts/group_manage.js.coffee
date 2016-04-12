$ ->
  $(document).on 'change', 'input[type="checkbox"].group-manage-all', ->
    checkboxes = $('input[type="checkbox"].group-manage')
    
    if $(this).is(':checked')
      checkboxes.prop('checked', true);
    else
      checkboxes.prop('checked', false);

    window.setGroupIds()


  $(document).on 'change', 'input[type="checkbox"].group-manage', ->
    window.setGroupIds()
    
    

  window.setGroupIds = ()->
    $(".group-manage-action").removeData('params');
    
    ids = []
    
    $.each $('input[type="checkbox"].group-manage:checked'), (index, item) ->
      ids.push(item.value)

    $(".group-manage-action").attr('data-params', $.param({ ids: ids }))

