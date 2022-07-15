import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1
import StatusQ.Controls 0.1

import "./private/statusMessage"

Rectangle {
    id: root

    enum ContentType {
        Unknown = 0,
        Text = 1,
        Emoji = 2,
        Image = 3,
        Sticker = 4,
        Audio = 5,
        Transaction = 6,
        Invitation = 7
    }

    property alias quickActions: quickActionsPanel.items
    property alias statusChatInput: editComponent.inputComponent
    property alias linksComponent: linksLoader.sourceComponent
    property alias transcationComponent: transactionBubbleLoader.sourceComponent
    property alias invitationComponent: invitationBubbleLoader.sourceComponent
    property alias mouseArea: mouseArea

    property string resendText: ""
    property string cancelButtonText: ""
    property string saveButtonText: ""
    property string loadingImageText: ""
    property string errorLoadingImageText: ""
    property string audioMessageInfoText: ""
    property string pinnedMsgInfoText: ""
    property var reactionIcons: [
        Emoji.iconSource("❤"),
        Emoji.iconSource("👍"),
        Emoji.iconSource("👎"),
        Emoji.iconSource("🤣"),
        Emoji.iconSource("😥"),
        Emoji.iconSource("😠")
    ]

    property string messageId: ""
    property bool isAppWindowActive: false
    property bool editMode: false
    property bool isAReply: false
    property bool isEdited: false
    property bool isChatBlocked: false

    property bool hasMention: false
    property bool isPinned: false
    property string pinnedBy: ""
    property bool hasExpired: false
    property double timestamp: 0
    property var reactionsModel: []

    readonly property bool dateGroupVisible: dateGroupLabel.visible
    property bool showHeader: true
    property bool isActiveMessage: false
    property bool disableHover: false
    property bool hideQuickActions: false
    property color overrideBackgroundColor: "transparent"
    property bool overrideBackground: false

    property alias previousMessageIndex: dateGroupLabel.previousMessageIndex
    property alias previousMessageTimestamp: dateGroupLabel.previousMessageTimestamp

    property StatusMessageDetails messageDetails: StatusMessageDetails {}
    property StatusMessageDetails replyDetails: StatusMessageDetails {}

    property string timestampString: Qt.formatTime(new Date(timestamp), "hh:mm");
    property string timestampTooltipString: Qt.formatTime(new Date(timestamp), "dddd, MMMM d, yyyy hh:mm:ss t");

    signal clicked(var sender, var mouse)
    signal profilePictureClicked(var sender, var mouse)
    signal senderNameClicked(var sender, var mouse)
    signal replyProfileClicked(var sender, var mouse)

    signal addReactionClicked(var sender, var mouse)
    signal toggleReactionClicked(int emojiId)
    signal imageClicked(var image, var mouse, var imageSource)
    signal stickerClicked()
    signal resendClicked()

    signal editCompleted(var newMsgText)
    signal editCancelled()
    signal stickerLoaded()
    signal linkActivated(string link)

    signal hoverChanged(string messageId, bool hovered)
    signal activeChanged(string messageId, bool active)

    function startMessageFoundAnimation() {
        messageFoundAnimation.start();
    }

    implicitWidth: messageLayout.implicitWidth
                   + messageLayout.anchors.leftMargin
                   + messageLayout.anchors.rightMargin

    implicitHeight: messageLayout.implicitHeight
                    + messageLayout.anchors.topMargin
                    + messageLayout.anchors.bottomMargin

    color: {
        if (root.overrideBackground)
            return root.overrideBackgroundColor;

        if (root.editMode)
            return Theme.palette.baseColor2;

        if (hoverHandler.hovered || root.isActiveMessage) {
           if (root.hasMention)
              return Theme.palette.mentionColor3;
           if (root.isPinned)
              return Theme.palette.pinColor2;
           return Theme.palette.baseColor2;
        }

        if (root.hasMention)
           return Theme.palette.mentionColor4;
        if (root.isPinned)
           return Theme.palette.pinColor3;
        return "transparent";
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: 2
        visible: root.isPinned
        color: Theme.palette.pinColor1
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: 2
        visible: root.hasMention
        color: Theme.palette.mentionColor1
    }

    SequentialAnimation {
        id: messageFoundAnimation

        PauseAnimation {
            duration: 600
        }
        NumberAnimation {
            target: highlightRect
            property: "opacity"
            to: 1.0
            duration: 1500
        }
        PauseAnimation {
            duration: 1000
        }
        NumberAnimation {
            target: highlightRect
            property: "opacity"
            to: 0.0
            duration: 1500
        }
    }

    Rectangle {
        id: highlightRect
        anchors.fill: parent
        opacity: 0
        visible: opacity > 0.001
        color: Theme.palette.baseColor2
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    HoverHandler {
        id: hoverHandler
        enabled: !root.isActiveMessage && !root.disableHover
    }

    ColumnLayout {
        id: messageLayout
        anchors.fill: parent
        anchors.topMargin: 8
        anchors.bottomMargin: 8

        StatusDateGroupLabel {
            id: dateGroupLabel
            Layout.fillWidth: true
            Layout.topMargin: 20
            messageTimestamp: root.timestamp
            visible: text !== ""
        }

        Loader {
            Layout.fillWidth: true
            active: isAReply
            visible: active
            sourceComponent: StatusMessageReply {
                replyDetails: root.replyDetails
                onReplyProfileClicked: root.replyProfileClicked(sender, mouse)
                audioMessageInfoText: root.audioMessageInfoText
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            spacing: 8

            Item {
                Layout.alignment: Qt.AlignTop

                implicitWidth: profileImage.effectiveSize.width
                implicitHeight: profileImage.visible ? profileImage.effectiveSize.height : 0

                StatusSmartIdenticon {
                    id: profileImage

                    active: root.showHeader
                    visible: active

                    name: root.messageDetails.sender.userName
                    image: root.messageDetails.sender.profileImage.imageSettings
                    icon: root.messageDetails.sender.profileImage.iconSettings
                    ringSettings: root.messageDetails.sender.profileImage.ringSettings

                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        anchors.fill: parent
                        onClicked: root.profilePictureClicked(this, mouse)
                    }
                }
            }

            ColumnLayout {
                spacing: 4
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true

                Loader {
                    active: root.isPinned && !editMode
                    visible: active
                    sourceComponent: StatusPinMessageDetails {
                        pinnedMsgInfoText: root.pinnedMsgInfoText
                        pinnedBy: root.pinnedBy
                    }
                }
                StatusMessageHeader {
                    Layout.fillWidth: true
                    sender: root.messageDetails.sender
                    amISender: root.messageDetails.amISender
                    resendText: root.resendText
                    showResendButton: root.hasExpired && root.messageDetails.amISender
                    onClicked: root.senderNameClicked(sender, mouse)
                    onResendClicked: root.resendClicked()
                    visible: root.showHeader && !editMode
                    timestamp.text: root.timestampString
                    timestamp.tooltip.text: root.timestampTooltipString
                }
                Loader {
                    Layout.fillWidth: true
                    active: !editMode && !!root.messageDetails.messageText
                    visible: active
                    sourceComponent: StatusTextMessage {
                        textField.text: {
                            if (root.messageDetails.contentType === StatusMessage.ContentType.Sticker)
                                return "";

                            const formattedMessage = Utils.linkifyAndXSS(root.messageDetails.messageText);

                            if (root.messageDetails.contentType === StatusMessage.ContentType.Emoji)
                                return Emoji.parse(formattedMessage, Emoji.size.middle, Emoji.format.png);

                            if (root.isEdited) {
                                const index = formattedMessage.endsWith("code>") ? formattedMessage.length : formattedMessage.length - 4;
                                const editedMessage = formattedMessage.slice(0, index)
                                                    + ` <span class="isEdited">` + qsTr("(edited)") + `</span>`
                                                    + formattedMessage.slice(index);
                                return Utils.getMessageWithStyle(Emoji.parse(editedMessage), textField.hoveredLink)
                            }

                            return Utils.getMessageWithStyle(Emoji.parse(formattedMessage), textField.hoveredLink)
                        }
                        onLinkActivated: {
                            root.linkActivated(link);
                        }
                    }

                }

                Loader {
                    active: root.messageDetails.contentType === StatusMessage.ContentType.Image && !editMode
                    visible: active
                    sourceComponent: StatusImageMessage {
                        source: root.messageDetails.contentType === StatusMessage.ContentType.Image ? root.messageDetails.messageContent : ""
                        onClicked: root.imageClicked(image, mouse, imageSource)
                        shapeType: root.messageDetails.amISender ? StatusImageMessage.ShapeType.RIGHT_ROUNDED : StatusImageMessage.ShapeType.LEFT_ROUNDED
                    }
                }
                Loader {
                    active: root.messageDetails.contentType === StatusMessage.ContentType.Sticker && !editMode
                    visible: active
                    sourceComponent: StatusSticker {
                        image.source: root.messageDetails.messageContent
                        onLoaded: root.stickerLoaded()
                        onClicked: {
                            root.stickerClicked()
                        }
                    }
                }
                Loader {
                    active: root.messageDetails.contentType === StatusMessage.ContentType.Audio && !editMode
                    visible: active
                    sourceComponent: StatusAudioMessage {
                        audioSource: root.messageDetails.messageContent
                        hovered: hoverHandler.hovered
                        audioMessageInfoText: root.audioMessageInfoText
                    }
                }
                Loader {
                    id: linksLoader
                    active: !root.editMode
                    visible: active
                }
                Loader {
                    id: transactionBubbleLoader
                    active: root.messageDetails.contentType === StatusMessage.ContentType.Transaction && !editMode
                    visible: active
                }
                Loader {
                    id: invitationBubbleLoader
                    active: root.messageDetails.contentType === StatusMessage.ContentType.Invitation && !editMode
                    visible: active
                }
                StatusEditMessage {
                    id: editComponent
                    Layout.fillWidth: true
                    Layout.rightMargin: 16
                    active: root.editMode
                    visible: active
                    msgText: root.messageDetails.messageText
                    saveButtonText: root.saveButtonText
                    cancelButtonText: root.cancelButtonText
                    onEditCancelled: root.editCancelled()
                    onEditCompleted: root.editCompleted(newMsgText)
                }
                StatusBaseText {
                    color: Theme.palette.dangerColor1
                    text: root.resendText
                    font.pixelSize: 12
                    visible: root.hasExpired && root.messageDetails.amISender && !root.timestamp && !editMode
                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: root.resendClicked()
                    }
                }
                Loader {
                    active: root.reactionsModel.count > 0
                    visible: active
                    sourceComponent: StatusMessageEmojiReactions {
                        id: emojiReactionsPanel

                        emojiReactionsModel: root.reactionsModel
                        store: root.messageStore
                        icons: root.reactionIcons

                        onHoverChanged: {
                            root.hoverChanged(messageId, hovered)
                        }

                        isCurrentUser: root.messageDetails.amISender
                        onAddEmojiClicked: root.addReactionClicked(sender, mouse)
                        onToggleReaction: root.toggleReactionClicked(emojiID)
                    }
                }
            }
        }
    }

    StatusMessageQuickActions {
        id: quickActionsPanel
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: -8
        visible: hoverHandler.hovered && !root.hideQuickActions
    }
}
