import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.2

import StatusQ.Controls 0.1
import StatusQ.Popups 0.1
import StatusQ.Components 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

ListView {
    id: messageList
    anchors.fill: parent
    anchors.margins: Theme.dp(15)
    clip: true
    delegate: StatusMessage {
        id: delegate
        width: parent.width

        audioMessageInfoText: "Audio Message"
        cancelButtonText: "Cancel"
        saveButtonText: "Save"
        loadingImageText: "Loading image..."
        errorLoadingImageText: "Error loading the image"
        resendText: "Resend"
        pinnedMsgInfoText: "Pinned by"

        messageDetails: StatusMessageDetails {
            contentType: model.contentType
            messageContent: model.messageContent
            amISender: model.amIsender
            displayName: model.userName
            secondaryName: model.localName !== "" && model.ensName.startsWith("@") ? model.ensName: ""
            chatID: model.chatKey
            profileImage: StatusImageSettings {
                width: Theme.dp(40)
                height: Theme.dp(40)
                source: model.profileImage
                isIdenticon: model.isIdenticon
            }
            messageText: model.message
            hasMention: model.hasMention
            isMutualContact: model.isMutualContact
            trustIndicator: model.trustIndicator
            isPinned: model.isPinned
            pinnedBy: model.pinnedBy
            hasExpired: model.hasExpired
        }
        timestamp.text: "10:00 am"
        timestamp.tooltip.text: "10:01 am"
        // reply related data
        isAReply: model.isReply
        replyDetails: StatusMessageDetails {
            amISender:  model.isReply ? model.replyAmISender : ""
            displayName:  model.isReply ? model.replySenderName: ""
            profileImage: StatusImageSettings {
                width: Theme.dp(20)
                height: Theme.dp(20)
                source:  model.isReply ? model.replyProfileImage: ""
                isIdenticon:  model.isReply ? model.replyIsIdenticon: ""
            }
            messageText:  model.isReply ? model.replyMessageText: ""
            contentType: model.replyContentType
            messageContent: model.replyMessageContent
        }
        quickActions: [
            StatusFlatRoundButton {
                id: emojiBtn
                width: Theme.dp(32)
                height: Theme.dp(32)
                icon.name: "reaction-b"
                type: StatusFlatRoundButton.Type.Tertiary
                tooltip.text: "Add reaction"
            },
            StatusFlatRoundButton {
                id: replyBtn
                width: Theme.dp(32)
                height: Theme.dp(32)
                icon.name: "reply"
                type: StatusFlatRoundButton.Type.Tertiary
                tooltip.text: "Reply"
            },
            StatusFlatRoundButton {
                width: Theme.dp(32)
                height: Theme.dp(32)
                icon.name: "tiny/edit"
                type: StatusFlatRoundButton.Type.Tertiary
                tooltip.text: "Edit"
                onClicked: {
                    delegate.editMode = !delegate.editMode
                }
            },
            StatusFlatRoundButton {
                id: otherBtn
                width: Theme.dp(32)
                height: Theme.dp(32)
                icon.name: "more"
                type: StatusFlatRoundButton.Type.Tertiary
                tooltip.text: "More"
            }
        ]
    }
}
