

$(document).on('turbolinks:load', function() {
  
    # if ($('#messages').length > 0) {
    #   messagesToButtom();
    #   App.global_chat = App.cable.subscriptions.create({
    #     channel: "ConversationsChannel",
    #     conversation_id: $("#messages").data('chat-room-id')
    #   }, {
    #     connected: function() {
    #
    #     },
    #     disconnected: function() {
    #
    #     },
    #     received: function(data) {
    #       $("#messages").append(data["message"]);
    #       messagesToButtom();
    #     },
    #     send_message: function(message, conversation_id) {
    #       return this.perform('send_message', {
    #         message: message,
    #         conversation_id: conversation_id
    #       });
    #     }
    #   });
    #   $('#new_message').submit(function(e) {
    #     console.log("hello");
    #     var textarea = $(this).find('#message_body')
    #     if ($.trim(textarea.val()).length > 1) {
    #       App.global_chat.send_message(textarea.val(), messages.data('chat-room-id'));
    #       textarea.val('');
    #     }
    #     e.preventDefault();
    #     return false;
    #   });
    # }
});
