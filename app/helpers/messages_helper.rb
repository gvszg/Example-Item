module MessagesHelper
  def link_to_create_record(user, message)
    unless user.messages.where(id: @message.id).present?
      link_to "發送訊息", new_message_record_admin_message_path(user_id: user.id), class: "btn btn-primary", method: :post
    else
      content_tag(:span, "已傳送通知訊息", class: "label label-default")
    end
  end
end