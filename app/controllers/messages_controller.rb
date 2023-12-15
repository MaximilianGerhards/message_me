class MessagesController < ApplicationController

    before_action :require_user

    def create
        message = Message.new(message_params)
        message.user = current_user
        #or: message = current_user.messages.build(message_params)
        if message.save
            redirect_to root_path
        end
    end

    private

    def message_params
        params.require(:message).permit(:text)
    end
end