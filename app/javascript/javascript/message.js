$(document).on('turbolinks:load', () => {
  if (window.location.href.match(/\/rooms\/\d+/)) {
    var element = document.documentElement;
    var bottom = element.scrollHeight - element.clientHeight;
    window.scroll(0, bottom);
  }
});

$(document).ready(() => {
  if (window.location.href.match(/\/rooms\/\d+/)) {
    var room_id = $('.room').data('room-id')
    $.ajax({
      url: '/api/messages/read_count',
      type: 'GET',
      data: { room_id: room_id },
      dataType: 'json'
    }).done(read_counts => {
      console.log(read_counts)
      read_counts.forEach(read_count => {
        $(`.message${read_count.messageId}-status`).text(`既読${read_count.count}`)
      });
      var element = document.documentElement;
      var bottom = element.scrollHeight - element.clientHeight;
      window.scroll(0, bottom);
    }).fail(() => {
      console.log('失敗')
    })
  }

  function buildMessage(message) {
    var createMessage = `
      <div class="line-bc m-0 message-body" data-message-id="${message.id}">
        <div class="balloon6">
          <div class="faceicon">
            <img class="user-circle-image rounded-circle" src="${message.senderImage}">
          </div>
        <p class="message-username">${message.sender}</p>
          <div class="chatting">
            <div class="says col-10 mr-auto">
              <p>${message.body}</p>
            </div>
          </div>
        </div>
      </div>
    `
    return createMessage;
  }

  var reloadMessages = () => {
    if (window.location.href.match(/\/rooms\/\d+/)) {
      var url = '/api/messages'
      var last_message_id = $('.message-body:last').data('message-id')
      var room_id = $('.room').data('room-id')

      $.ajax({
        url: url,
        type: 'GET',
        data: { id: last_message_id, room_id: room_id },
        dataType: 'json'
      }).done(messages => {        var insertMessages = '';
        messages.forEach(message => {
          insertMessages = buildMessage(message)
          $('.room').append(insertMessages)
        });
      }).fail(() => {
      })

      $.ajax({
        url: '/api/messages/read_count',
        type: 'GET',
        data: { room_id: room_id },
        dataType: 'json'
      }).done(read_counts => {
        read_counts.forEach(read_count => {
          $(`.message${read_count.messageId}-status`).text(`既読${read_count.count}`)
        });
      }).fail(() => {
      })
    }
  }
  setInterval(reloadMessages, 30000);
})