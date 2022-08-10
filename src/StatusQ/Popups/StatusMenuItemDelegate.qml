import QtQuick 2.13
import QtQuick.Controls 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Popups 0.1

MenuItem {
    id: root
    implicitWidth: parent ? parent.width : 0
    implicitHeight: menu.hideDisabledItems && !enabled ? 0 : 38
    objectName: action ? action.objectName : "StatusMenuItemDelegate"

//    property int subMenuIndex
//    property var statusPopupMenu: null

    readonly property string logObjectName: "StatusMenuItemDelegate [%1, %2]".arg(this).arg(text)

//    Component.onCompleted: {
//        console.log("<---", logObjectName, " completed:", statusPopupMenu, menu, subMenu, action)
//    }

//    onMenuChanged: console.log("<--- ", logObjectName, " menu changed: ", menu)
//    onActionChanged: console.log("<--- ", logObjectName, " action changed: ", action, action.text, text)

    action: StatusMenuItem {
//        onTriggered: { statusPopupMenu.menuItemClicked(root.subMenuIndex); }
    }

    QtObject {
        id: d

        readonly property bool isSubMenu: !!root.subMenu
        readonly property bool isStatusSubMenu: isSubMenu && (root.subMenu instanceof StatusPopupMenu)
        readonly property bool hasAction: !!root.action
        readonly property bool isStatusAction: d.hasAction && (root.action instanceof StatusMenuItem)
        readonly property bool isDangerIcon: d.isStatusAction && root.action.type === StatusMenuItem.Type.Danger

        readonly property StatusImageSettings imageSettings: d.isStatusSubMenu
                                                     ? root.subMenu.imageSettings
                                                     : d.isStatusAction ? root.action.image : d.defaultImage

        readonly property StatusIconSettings iconSettings: {
            console.log("<<<--- Calling iconSettings", root.logObjectName)
            return d.isStatusSubMenu
                    ? root.subMenu.iconSettings
                    : d.isStatusAction ? root.action.iconSettings : d.defaultIcon
        }

        readonly property StatusFontSettings fontSettings: d.isStatusSubMenu
                                                           ? root.subMenu.fontSettings
                                                           : d.isStatusAction ? root.action.fontSettings : d.defaultFontSettings

        readonly property StatusImageSettings defaultImage: StatusImageSettings {
            width: 16
            height: 16
        }
        readonly property StatusIconSettings defaultIcon: StatusIconSettings {
            width: 18
            height: 18
            rotation: 0
        }
        readonly property StatusFontSettings defaultFontSettings: StatusFontSettings {
            pixelSize: 13
            bold: false
            italic: false
        }
    }

    Component {
        id: indicatorIcon

        StatusIcon {
            width: d.iconSettings.width // TODO: Also process action.icon.width?
            height: d.iconSettings.height // TODO: Also process action.icon.height?
            rotation: d.iconSettings.rotation // TODO: Also process action.icon.rotation? // !!root.action.iconRotation ? root.action.iconRotation : 0
            icon: d.iconSettings.name // TODO: Also process action.icon?
            color: {
                const c = d.iconSettings.color;
                if (!Qt.colorEqual(c, "transparent"))
                    return c;
                if (d.isDangerIcon)
                    return Theme.palette.dangerColor1;
                return Theme.palette.primaryColor1;
            }
        }
    }

    Component {
        id: indicatorLetterIdenticon

        StatusLetterIdenticon {
            width: d.imageSettings.width
            height: d.imageSettings.height
            color: d.iconSettings.color
            name: root.text
            letterSize: 11
        }
    }

    Component {
        id: indicatorImage

        StatusRoundedImage {
            width: d.imageSettings.width
            height: d.imageSettings.height
            image.source: d.imageSettings.source
            border.width: d.isSubMenu && d.imageSettings.isIdenticon ? 1 : 0
            border.color: Theme.palette.directColor7
        }
    }

    indicator: Item {
        implicitWidth: 24
        implicitHeight: 24
        Loader {
            anchors.centerIn: parent
    //        sourceComponent: {
    //            if (!!d.imageSettings.source.toString())
    //                return indicatorImage;
    //            if (d.iconSettings.isLetterIdenticon)
    //                return indicatorLetterIdenticon;
    //            return indicatorIcon;
    //        }

    //        sourceComponent: indicatorIcon
    //        sourceComponent: indicatorLetterIdenticon
    //        sourceComponent: indicatorImage

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
    //        active: enabled // TODO: Also process action.icon.name ?
    //                && (d.iconSettings.isLetterIdenticon
    //                    || !!d.iconSettings.name
    //                    || !!d.imageSettings.source.toString())
        }
    }

    contentItem: StatusBaseText {
        anchors.left: root.indicator.right
        anchors.right: arrowIcon.visible ? arrowIcon.left : arrowIcon.right
        anchors.rightMargin: 8
        anchors.leftMargin: 4

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        text: root.text
        color: d.isDangerIcon ? Theme.palette.dangerColor1 : Theme.palette.directColor1
        font.pixelSize: d.fontSettings.pixelSize // !!root.action.fontSettings ? root.action.fontSettings.pixelSize : 13
        font.bold: d.fontSettings.bold // !!root.action.fontSettings ? root.action.fontSettings.bold : false
        font.italic: d.fontSettings.italic // !!root.action.fontSettings ? root.action.fontSettings.italic : false
        elide: Text.ElideRight
        visible: true // hideDisabledItems ? root.enabled : true
    }

    arrow: StatusIcon {
        id: arrowIcon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8
        height: 16
        visible: d.isSubMenu
        icon: "next"
        color: Theme.palette.directColor1
    }

    background: Rectangle {
        color: {
            if (!root.hovered)
                return "transparent"
            if (root.action.type === StatusMenuItem.Type.Danger)
                return Theme.palette.dangerColor3;
            return Theme.palette.statusPopupMenu.hoverBackgroundColor;
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: root.enabled // WARNING: use root.enabled ?
        onPressed: mouse.accepted = false
    }
}
