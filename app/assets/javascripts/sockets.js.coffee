window.updateStats = ->
  $.ajax 
    url: '/stats',
    method: 'POST', 
    dataType: 'script'
    

window.updateMessages = ->
  conversationId = $('#messages').attr('data-conversation-id')

  if conversationId != undefined
  
    $.ajax 
      url: '/conversations/' + conversationId + '/messages',
      method: 'GET', 
      dataType: 'script'


if window.location.protocol == "https:"
  protocol = "wss://"
else  
  protocol = "ws://"
  
window.cable = Cable.createConsumer(protocol + window.location.host + "/websocket")

window.cable.subscriptions.create 'MessagesChannel', 
  received: (data) -> 
    window.updateStats()
  