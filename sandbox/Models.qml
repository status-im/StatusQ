import QtQuick 2.14
import StatusQ.Components 0.1

QtObject {

    property var demoChatListItems: ListModel {
        id: demoChatListItems
        ListElement {
            chatId: "0"
            name: "#status"
            chatType: StatusChatListItem.Type.PublicChat
            muted: false
            unreadMessagesCount: 0
            mentionsCount: 0
            color: "blue"
        }
        ListElement {
            chatId: "1"
            name: "status-desktop"
            chatType: StatusChatListItem.Type.PublicChat
            muted: false
            color: "red"
            unreadMessagesCount: 1
            mentionsCount: 1
        }
        ListElement {
            chatId: "2"
            name: "Amazing Funny Squirrel"
            chatType: StatusChatListItem.Type.OneToOneChat
            muted: false
            color: "green"
            identicon: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0Bh
CExPynn1gWf9bx498P7/nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
            unreadMessagesCount: 0
        }
        ListElement {
            chatId: "3"
            name: "Black Ops"
            chatType: StatusChatListItem.Type.GroupChat
            muted: false
            color: "purple"
            unreadMessagesCount: 0
        }
        ListElement {
            chatId: "4"
            name: "Spectacular Growing Otter"
            chatType: StatusChatListItem.Type.OneToOneChat
            muted: true
            color: "Orange"
            unreadMessagesCount: 0
        }
        ListElement {
            chatId: "5"
            name: "channel-with-a-super-duper-long-name"
            chatType: StatusChatListItem.Type.PublicChat
            muted: false
            color: "green"
            unreadMessagesCount: 0
        }
    }

    property var demoCommunityChatListItems: ListModel {
        id: demoCommunityChatListItems
        ListElement {
            chatId: "0"
            name: "general"
            chatType: StatusChatListItem.Type.CommunityChat
            muted: false
            unreadMessagesCount: 0
            color: "orange"
        }
        ListElement {
            chatId: "1"
            name: "random"
            chatType: StatusChatListItem.Type.CommunityChat
            muted: false
            unreadMessagesCount: 0
            color: "orange"
            categoryId: "public"
        }
        ListElement {
            chatId: "2"
            name: "watercooler"
            chatType: StatusChatListItem.Type.CommunityChat
            muted: false
            unreadMessagesCount: 0
            color: "orange"
            categoryId: "public"
        }
        ListElement {
            chatId: "3"
            name: "language-design"
            chatType: StatusChatListItem.Type.CommunityChat
            muted: false
            unreadMessagesCount: 0
            color: "orange"
            categoryId: "dev"
        }
    }

    property var demoCommunityCategoryItems: ListModel {
        id: demoCommunityCategoryItems
        ListElement {
            categoryId: "public"
            name: "Public"
        }
        ListElement {
            categoryId: "dev"
            name: "Development"
        }
    }

    property var demoProfileGeneralMenuItems: ListModel {
        id: demoProfileGeneralMenuItems

        ListElement {
            title: "My Profile"
            icon: "profile"
        }

        ListElement {
            title: "Contacts"
            icon: "contact"
        }

        ListElement {
            title: "ENS Usernames"
            icon: "username"
        }

    }

    property var demoProfileSettingsMenuItems: ListModel {
        id: demoProfileSettingsMenuItems

        ListElement {
            title: "Privacy & Security"
            icon: "security"
        }

        ListElement {
            title: "Appearance"
            icon: "appearance"
        }

        ListElement {
            title: "Browser"
            icon: "browser"
        }

        ListElement {
            title: "Sounds"
            icon: "sound"
        }

        ListElement {
            title: "Language"
            icon: "language"
        }

        ListElement {
            title: "Notifications"
            icon: "notification"
        }

        ListElement {
            title: "Sync settings"
            icon: "mobile"
        }

        ListElement {
            title: "Advanced"
            icon: "settings"
        }

    }

    property var demoProfileOtherMenuItems: ListModel {
        id: demoProfileOtherMenuItems

        ListElement {
            title: "Need help?"
            icon: "help"
        }

        ListElement {
            title: "About"
            icon: "info"
        }

        ListElement {
            title: "Sign out & Quit"
            icon: "logout"
        }
    }

    //dummy search popup models
    property var searchResultsA: ListModel {
        ListElement { name: "@Flea"; type: "Messages"; time: "18:55 AM"; content: "lorem ipsum <font color='#4360DF'>@Nick</font> dolor sit amet";
            badgeImage: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg";
            badgePrimaryText: "CryptoKities";
            badgeSecondaryText: "";
            badgeIdenticonColor: "";
            isLetterIdenticon: false }
        ListElement { name: "core"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "communities-phase3"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "core-ui"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "desktop"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "Crocodile Vanilla Bird"; type: "Chat"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "carmen eth"; type: "Chat"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "CryptoKitties"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "MyCommunity"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "Foo"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
    }
    property var searchResultsB: ListModel {
        ListElement { name: "@Ant"; type: "Messages"; time: "11:43 AM"; content: "<font color='#4360DF'>@John</font>, lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum ";
            badgeImage: "";
            badgePrimaryText: "CryptoKities";
            badgeSecondaryText: "#design";
            badgeIdenticonColor: "pink"; isLetterIdenticon: true }
        ListElement { name: "support"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "desktop-ui"; type: "Channels"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "climate-change"; type: "Chat"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "food"; type: "Chat"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: "pink"; isLetterIdenticon: true }
        ListElement { name: "CryptoKitties"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "CryptoRangers"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: ""; isLetterIdenticon: false }
        ListElement { name: "Foo"; type: "Communities"; time: ""; content: ""; badgeImage: ""; badgePrimaryText: ""; badgeSecondaryText: ""; badgeIdenticonColor: "orange"; isLetterIdenticon: true }
    }

    property ListModel optionsModel: ListModel {
        ListElement { title: "Chat";
            imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
            subItems: [
                ListElement {
                    text: "Pascal"
                    imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
                    iconName: ""
                    identiconColor: ""
                    isIdenticon: false
                },
                ListElement {
                    text: "vitalik.eth"
                    imageSource: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAlklEQVR4nOzW0QmDQBAG4SSkl7SUQlJGCrElq9F3QdjjVhh/5nv3cFhY9vUIYQiNITSG0Bh
                                   CExPynn1gWf9bx498P7/nzPcxEzGExhBdJGYihtAYQlO+tUZvqrPbqeudo5iJGEJjCE15a3VtodH3q2ImYgiNITTlTdG1nUZ5a92VITQxITFiJmIIjSE0htAYQrMHAAD//+wwFVpz+yqXAAAAAElFTkSuQmCC"
                    iconName: "private-chat"
                    identiconColor: ""
                    isIdenticon: true
                }]}
        ListElement { title: "Cryptokitties";
            imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
            subItems: [
                ListElement {
                    text: "#welcome"
                    imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
                    iconName: ""
                    identiconColor: ""
                    isIdenticon: false
                },
                ListElement {
                    text: "#support"
                    imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
                    iconName: ""
                    identiconColor: ""
                    isIdenticon: false
                },
                ListElement {
                    text: "#news"
                    imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
                    iconName: ""
                    identiconColor: ""
                    isIdenticon: false
                }]}
        ListElement { title: "Another community";
            imageSource: "";
            subItems: [
                ListElement {
                    text: "#news"
                    imageSource: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
                    iconName: ""
                    identiconColor: "red"
                    isIdenticon: false
                }]}
    }
}
