class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(message_params[:room_id])
    @new_message = Message.new(message_params)
    begin
      ActiveRecord::Base.transaction do
        # メッセージの送信と同時にmessages_receiversテーブルにもレコードを入れる。
        @new_message.save!
        # roomに所属する送信者以外がメッセージを受け取る（バルクインサート）
        receiver_ids = @room.entries.where(is_deleted: false).pluck(:user_id).delete(current_user.id)
        new_record = []
        Array(receiver_ids).each do |user_id|
          new_record << MessagesReceiver.new(
            receiver_id: user_id,
            message_id: @new_message.id
          )
        end
        MessagesReceiver.import! new_record
      end
    rescue => e
      logger.error "メッセージ送信エラー: #{e}"
      @messages = @room.messages.where(is_deleted: false).order(:created_at)
      return render 'rooms/show', alert: "メッセージの送信に失敗しました。"
    end
    redirect_to room_path(@room)
  end

  private
    def message_params
      params.require(:message).permit(:room_id, :sender_id, :body)
    end
end
