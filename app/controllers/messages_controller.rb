class MessagesController < ApplicationController

    before_action :require_user

    def create
        message = Message.new(message_params)
        message.user = current_user
        #or: message = current_user.messages.build(message_params)
        if message.save
            ActionCable.server.broadcast "chatroom_channel", rendered_message: render_message(message)
        end
    end

    private

    def message_params
        params.require(:message).permit(:text)
    end

    def render_message(message)
        render(partial: 'message', locals: { message: message })
    end
end