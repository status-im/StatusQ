import QtQuick 2.14
import QtQuick.Layouts 1.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1
import StatusQ.Core.Utils 0.1

GridLayout {
    columns: 1
    columnSpacing: Theme.dp(5)
    rowSpacing: Theme.dp(5)

    StatusNavigationListItem {
        title: "Menu Item"
    }

    StatusNavigationListItem {
        title: "Menu Item"
        icon.name: "info"
    }

    StatusNavigationListItem {
        title: "Menu Item"
        icon.name: "info"
        badge.value: 1
    }
    StatusNavigationListItem {
        title: "Menu Item (selected) with very long text"
        selected: true
        icon.name: "info"
        badge.value: 1
    }

    StatusChatListItem {
        id: test
        name: "public-channel"
        type: StatusChatListItem.Type.PublicChat
    }

    StatusChatListCategoryItem {
        title: "Chat list category"
        opened: false
        showActionButtons: true
    }

    StatusChatListCategoryItem {
        title: "Chat list category (opened)"
        opened: true
        showActionButtons: true
    }

    StatusChatListCategoryItem {
        title: "Chat list category (no buttons)"
        opened: true
    }

    StatusChatListItem {
        name: "group-chat"
        type: StatusChatListItem.Type.GroupChat
    }

    StatusChatListItem {
        name: "community-channel"
        type: StatusChatListItem.Type.CommunityChat
    }

    StatusChatListItem {
        name: "community-channel-emoji"
        type: StatusChatListItem.Type.CommunityChat
        icon.emoji: "😁"
    }

    StatusChatListItem {
        name: "community-channel-with-image"
        image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
        type: StatusChatListItem.Type.CommunityChat
    }

    StatusChatListItem {
        name: "Weird Crazy Otter"
        image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
        type: StatusChatListItem.Type.OneToOneChat
    }

    StatusChatListItem {
        name: "has-unread-messages"
        type: StatusChatListItem.Type.PublicChat
        hasUnreadMessages: true
    }

    StatusChatListItem {
        name: "has-mentions"
        type: StatusChatListItem.Type.PublicChat
        hasUnreadMessages: true
        notificationsCount: 1
    }

    StatusChatListItem {
        name: "is-muted"
        type: StatusChatListItem.Type.PublicChat
        muted: true
        onUnmute: muted = false
    }

    StatusChatListItem {
        name: "muted-with-mentions"
        type: StatusChatListItem.Type.PublicChat
        muted: true
        hasUnreadMessages: true
        notificationsCount: 1
    }

    StatusChatListItem {
        name: "selected-channel"
        type: StatusChatListItem.Type.PublicChat
        selected: true
    }

    StatusChatListItem {
        name: "selected-muted-channel"
        type: StatusChatListItem.Type.PublicChat
        selected: true
        muted: true
    }

    StatusChatListItem {
        name: "selected-muted-channel-with-unread-messages"
        type: StatusChatListItem.Type.PublicChat
        selected: true
        muted: true
        hasUnreadMessages: true
    }

    StatusChatListItem {
        name: "selected-muted-with-mentions"
        type: StatusChatListItem.Type.PublicChat
        selected: true
        muted: true
        hasUnreadMessages: true
        notificationsCount: 1
    }


    StatusListItem {
        title: "Title"
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        tertiaryTitle: "Tertiary title"

        statusListItemTitle.font.pixelSize: Theme.dp(17)
        statusListItemTitle.font.weight: Font.Bold
    }

    StatusListItem {
        title: "Title"
        subTitle: "Super long description that causes a multiline paragraph and makes the size of the component grow. Let's see how it behaves."
        tertiaryTitle: "Tertiary title"
        icon.name: "info"

        statusListItemTitle.font.pixelSize: Theme.dp(17)
        statusListItemTitle.font.weight: Font.Bold
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        image.source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0Bh
CExPynn1gWf9bx498P7/nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
        image.isIdenticon: true
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        components: [StatusButton {
            text: "Button"
            size: StatusBaseButton.Size.Small
        }]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        components: [StatusSwitch {}]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        components: [StatusRadioButton {}]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        components: [StatusCheckBox {}]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
        components: [
            StatusButton {
                text: "Button"
                size: StatusBaseButton.Size.Small
            }
        ]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
        components: [StatusSwitch {}]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
        components: [
          StatusRadioButton {}
        ]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
        components: [StatusCheckBox {}]
    }

    StatusListItem {
        title: "Title"
        subTitle: "Subtitle"
        icon.name: "info"
        label: "Text"
        components: [
            StatusBadge {
                value: 1
            },
            StatusIcon {
                icon: "info"
                color: Theme.palette.baseColor1
                width: 20
                height: 20
            }
        ]
    }

    StatusListItem {
        title: "Title"
        icon.name: "info"
        type: StatusListItem.Type.Secondary
    }

    StatusListItem {
        title: "Title"
        icon.isLetterIdenticon: true
        icon.color: "orange"
    }

    StatusListItem {
        title: "Title"
        titleAsideText: "test"
    }

    StatusListItem {
        title: "Title"
        icon.name: "delete"
        type: StatusListItem.Type.Danger
    }

    StatusListItem {
        title: "List Item with Badge"
        subTitle: "Subtitle"
        image.source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0Bh
CExPynn1gWf9bx498P7/nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
        image.isIdenticon: true
        badge.image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
        badge.primaryText: "CryptoKitties"
        badge.secondaryText: "#test"
    }

    StatusListItem {
        title: "List Item with Badge 2"
        subTitle: "Subtitle"
        icon.isLetterIdenticon: true
        badge.primaryText: "CryptoKitties"
        badge.secondaryText: "#test"
        badge.icon.color: "orange"
        badge.icon.isLetterIdenticon: true
    }

    StatusListItem {
        title: "List Item with Tags"
        icon.isLetterIdenticon: true
        bottomModel: 3
        bottomDelegate: StatusListItemTag {
            title: "tag"
            icon.isLetterIdenticon: true
        }
    }

    StatusListItem {
        title: "List Item with Inline Tags"
        icon.isLetterIdenticon: true
        tagsModel : 2
        tagsDelegate: StatusListItemTag {
            color: "blue"
            height: Theme.dp(24)
            radius: Theme.dp(6)
            closeButtonVisible: false
            icon.emoji: "😁"
            icon.emojiSize: Emoji.size.verySmall
            icon.isLetterIdenticon: true
            title: "helloworld.eth"
            titleText.font.pixelSize: Theme.dp(12)
            titleText.color: Theme.palette.indirectColor1
        }
    }

    StatusListItem {
        title: "List Item with Emoji"
        subTitle: "Emoji"
        icon.emoji: "😁"
        icon.color: "yellow"
        icon.letterSize: Theme.dp(14)
        icon.isLetterIdenticon: true
    }

    StatusDescriptionListItem {
        title: "Title"
        subTitle: "Subtitle"
    }

    StatusDescriptionListItem {
        title: "Title"
        subTitle: "Subtitle"
        value: "None"
        sensor.enabled: true
    }

    StatusDescriptionListItem {
        title: "Title"
        subTitle: "Subtitle"
        tooltip.text: "Tooltip"
        icon.name: "info"
        iconButton.onClicked: tooltip.visible = !tooltip.visible
    }

    StatusContactRequestsIndicatorListItem {
        title: "Contact requests"
        requestsCount: 3
    }

    StatusMemberListItem {
        nickName: "This is an example"
        userName: "annabelle"
        pubKey: "0x043a7ed0e8752236a4688563652fd0296453cef00a5dcddbe252dc74f72cc1caa97a2b65e4a1a52d9c30a84c9966beaaaf6b333d659cbdd2e486b443ed1012cf04"
        isVerified: true
        isContact: true
        image.source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0BhCExPynn1gWf9bx498P7/
                      nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
        image.isIdenticon: true
        status: 1 // FIXME: use enum
        ringSettings.ringSpecModel:
            ListModel {
                ListElement {colorId: 13; segmentLength: 5}
                ListElement {colorId: 31; segmentLength: 5}
                ListElement {colorId: 10; segmentLength: 1}
                ListElement {colorId: 2; segmentLength: 5}
                ListElement {colorId: 26; segmentLength: 2}
                ListElement {colorId: 19; segmentLength: 4}
                ListElement {colorId: 28; segmentLength: 3}
            }
        ringSettings.distinctiveColors: Theme.palette.identiconRingColors
    }

    StatusMemberListItem {
        nickName: "carmen.eth"
        isUntrustworthy: true
    }

    StatusMemberListItem {
        nickName: "very-long-annoying-nickname.eth"
        isUntrustworthy: true
    }

    StatusMemberListItem {
        nickName: "This girl I know from work"
        userName: "annabelle"
        status: 1 // FIXME: use enum
    }

    StatusMemberListItem {
        nickName: "Mark Cuban"
        userName: "annabelle"
        pubKey: "0x043a7ed0e8752236a4688563652fd0296453cef00a5dcddbe252dc74f72cc1caa97a2b65e4a1a52d9c30a84c9966beaaaf6b333d659cbdd2e486b443ed1012cf04"
        isContact: true
        image.source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0BhCExPynn1gWf9bx498P7/
                       nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
        image.isIdenticon: true
    }

    StatusMemberListItem {
        nickName: "admin.guy"
        isAdmin: true
        isUntrustworthy: true
    }

    StatusBaseText {
        Layout.fillWidth: true
        Layout.topMargin: 16
        text: "Loading features:"
        font.pixelSize: 17
    }

    StatusListItem {
        title: "Nokia 3310"
        subTitle: "Incoming device"
        label: "loading: true"
        icon.emoji: "😁"
        icon.color: "hotpink"
        icon.letterSize: 14
        icon.isLetterIdenticon: true
        loading: true
    }

    StatusListItem {
        title: "Nokia 3310"
        subTitle: "Device"
        label: "loadingFailed: true"
        icon.emoji: "😁"
        icon.color: "hotpink"
        icon.letterSize: 14
        icon.isLetterIdenticon: true
        loadingFailed: true
    }
}
