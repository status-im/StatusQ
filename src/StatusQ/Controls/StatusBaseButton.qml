import QtQuick 2.14
import QtQuick.Controls 2.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Core.Utils 0.1
Button {
    id: root

    enum Size {
        Tiny,
        Small,
        Large
    }

    enum Type {
        Normal,
        Danger
    }

    property StatusAssetSettings asset: StatusAssetSettings { }

    property bool loading: false

    property color normalColor
    property color hoverColor
    property color disabledColor

    property color textColor
    property color disabledTextColor
    property color borderColor: "transparent"

    property int size: StatusBaseButton.Size.Large
    property int type: StatusBaseButton.Type.Normal

    implicitWidth: (contentItem.width + root.leftPadding + root.rightPadding)
    implicitHeight: (contentItem.height + root.topPadding + root.bottomPadding)
    leftPadding: (horizontalPadding > 0) ? horizontalPadding : ((size === StatusBaseButton.Size.Large) ? 24 : 12)
    rightPadding: leftPadding
    topPadding: {
        if (verticalPadding > 0) {
            verticalPadding;
        } else {
            switch (size) {
            case StatusBaseButton.Size.Tiny:
                return 5;
            case StatusBaseButton.Size.Small:
                return 10;
            case StatusBaseButton.Size.Large:
            default:
                return 11;
            }
        }
    }
    bottomPadding: topPadding
    enabled: !loading
    font.pixelSize: size === StatusBaseButton.Size.Large ? 15 : 13 // by design

    background: Rectangle {
        radius: root.size !== StatusBaseButton.Size.Tiny ? 8 : 6
        border.color: root.borderColor
        color: {
            if (root.enabled)
                return root.hovered || highlighted ? hoverColor : normalColor;
            return disabledColor
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: loading ? Qt.ArrowCursor : Qt.PointingHandCursor;
        }
    }

    QtObject {
        id: d
        readonly property color textColor: root.enabled ? root.textColor : root.disabledTextColor
    }

    contentItem: Item {
        width: layout.width
        height: layout.height

        Loader {
            anchors.centerIn: parent
            active: loading
            sourceComponent: StatusLoadingIndicator {
                color: d.textColor
            }
        }

        Row {
            id: layout
            anchors.centerIn: parent
            spacing: 4
            StatusIcon {
                id: statusIcon
                width: root.icon.width
                height: root.icon.height
                icon: root.icon.name
                rotation: root.asset.rotation
                anchors.verticalCenter: parent.verticalCenter
                opacity: !loading && root.icon.name !== ""
                visible: root.icon.name !== ""
                color: d.textColor
            }
            StatusEmoji {
                width: root.icon.width
                height: root.icon.height
                anchors.verticalCenter: parent.verticalCenter
                visible: root.asset.emoji
                emojiId: Emoji.iconId(root.asset.emoji, root.asset.emojiSize) || ""
            }
            StatusBaseText {
                id: label
                opacity: !loading
                anchors.verticalCenter: parent.verticalCenter
                font: root.font
                text: root.text
                color: d.textColor
            }
        }
    }
}
