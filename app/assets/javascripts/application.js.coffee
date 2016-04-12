//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap-select/js/bootstrap-select
//= require ajax-bootstrap-select/dist/js/ajax-bootstrap-select.min
//= require s3_direct_upload
//= require spin
//= require ladda
//= require group_manage
//= require cable
//= require sockets

$ ->
  $('#ajax-modal').on 'hidden.bs.modal', ->
    $(this).data('bs.modal', null)
  
  if $('body').hasClass('browse')
    navigator.geolocation.getCurrentPosition (position)->
      $.ajax 
        url: '/browse',
        method: 'GET', 
        dataType: 'script',
        data: { lat: position.coords.latitude, lng: position.coords.longitude }
    
    
window.closeModal = () ->
  $('#ajax-modal').modal('hide')
  $('#ajax-modal').data('bs.modal', null)

  



