import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Popups 0.1


Menu {
    id: root

//    Component.onCompleted:  {
//        let parents = "";
//        let p = parent;
//        while (p) {
//            parents += " <- " + p;
//            p = p.parent;
//        }
////        console.log("<-- StatusPopupMenu created", this, parents);
//    }

    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
    topPadding: 8
    bottomPadding: 8

//    property int menuItemCount: 0
//    property var subMenuItemIcons: []

    //    source: model.imageSource,                                // -> StatusRoundedImage.image.source
    //    icon: model.iconName,                                     // -> StatusIcon.icon
    //    isIdenticon: model.isIdenticon,                           // -> StatusRoundImage.border.width
    //    color: model.iconColor,                                   // -> StatusLetterIdenticon.color,
    //    isLetterIdenticon: !model.imageSource && !model.iconName  // -> decide indicator component

    property StatusImageSettings imageSettings: StatusImageSettings {
        height: 16
        width: 16
        isIdenticon: false
    }

    property StatusIconSettings iconSettings: StatusIconSettings {
        width: 18
        height: 18
        rotation: 0
        isLetterIdenticon: false
        background: StatusIconBackgroundSettings {}
        color: "transparent"
    }

    property StatusFontSettings fontSettings: StatusFontSettings {}

    property bool hideDisabledItems: false

    property var openHandler
    property var closeHandler

    signal menuItemClicked(int menuIndex)

    dim: false

    onOpened: {
        if (typeof openHandler === "function") {
            openHandler()
        }
    }

    onClosed: {
        if (typeof closeHandler === "function") {
            closeHandler()
        }
    }

    delegate: StatusMenuItemDelegate {
//        statusPopupMenu: root
    }

    background: Item {
        id: statusPopupMenuBackground
        implicitWidth: 176

        Rectangle {
            id: statusPopupMenuBackgroundContent
            implicitWidth: statusPopupMenuBackground.width
            implicitHeight: statusPopupMenuBackground.height
            color: Theme.palette.statusPopupMenu.backgroundColor
            radius: 8
            layer.enabled: true
            layer.effect: DropShadow {
                width: statusPopupMenuBackgroundContent.width
                height: statusPopupMenuBackgroundContent.height
                x: statusPopupMenuBackgroundContent.x
                visible: statusPopupMenuBackgroundContent.visible
                source: statusPopupMenuBackgroundContent
                horizontalOffset: 0
                verticalOffset: 4
                radius: 12
                samples: 25
                spread: 0.2
                color: Theme.palette.dropShadow
            }
        }
    }
}
