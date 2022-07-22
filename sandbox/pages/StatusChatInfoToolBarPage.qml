import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.13

import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Popups 0.1

GridLayout {
    columns: 1
    columnSpacing: 5
    rowSpacing: 5

    StatusChatInfoToolBar {
        chatInfoButton.title: "Cryptokitties"        
        chatInfoButton.subTitle: "128 Members"
        chatInfoButton.image.source: "qrc:/demoapp/data/profile-image-1.jpeg"
        chatInfoButton.icon.color: Theme.palette.miscColor6

        popupMenu: StatusPopupMenu {

            StatusMenuItem {
                text: "Create channel"
                icon.name: "channel"
            }

            StatusMenuItem {
                text: "Create category"
                icon.name: "channel-category"
            }

            StatusMenuSeparator {}

            StatusMenuItem {
                text: "Invite people"
                icon.name: "share-ios"
            }
        }
    }
}
