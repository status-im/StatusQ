import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

ToolTip {
    id: statusToolTip

    enum Orientation {
        Top,
        Bottom,
        Left,
        Right
    }

    property int maxWidth: Theme.dp(800)
    property int orientation: StatusToolTip.Orientation.Top
    property int offset: 0
    property alias arrow: arrow

    implicitWidth: Math.min(maxWidth, textContent.implicitWidth + 16)
    leftPadding: Theme.dp(8)
    rightPadding: Theme.dp(8)
    topPadding: Theme.dp(8)
    bottomPadding: Theme.dp(8)
    delay: 200
    background: Item {
        id: statusToolTipBackground
        Rectangle {
            id: statusToolTipContentBackground
            color: Theme.palette.black
            radius: Theme.dp(8)
            anchors.fill: parent
            anchors.bottomMargin: Theme.dp(8)
        }
        Rectangle {
            id: arrow
            color: statusToolTipContentBackground.color
            height: Theme.dp(20)
            width: Theme.dp(20)
            rotation: 45
            radius: Theme.dp(1)
            x: {
                if (orientation === StatusToolTip.Orientation.Top || orientation === StatusToolTip.Orientation.Bottom) {
                    return statusToolTipBackground.width / 2 - width / 2 + offset
                }
                if (orientation === StatusToolTip.Orientation.Left) {
                    return statusToolTipContentBackground.width - (width / 2) - Theme.dp(8) + offset
                }
                if (orientation === StatusToolTip.Orientation.Right) {
                    return -width/2 + Theme.dp(8) + offset
                }
            }
            y: {
                if (orientation === StatusToolTip.Orientation.Bottom) {
                    return -height / 2 + Theme.dp(5)
                }
                if (orientation === StatusToolTip.Orientation.Top) {
                    return statusToolTipBackground.height - height - Theme.dp(5)
                }
                if (orientation === StatusToolTip.Orientation.Left || orientation === StatusToolTip.Orientation.Right) {
                    return statusToolTipContentBackground.height / 2 - (height / 2)
                }
            }
        }
    }
    contentItem: StatusBaseText {
        id: textContent
        text: statusToolTip.text
        color: Theme.palette.white
        wrapMode: Text.WordWrap
        font.pixelSize: Theme.dp(13)
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
        bottomPadding: Theme.dp(8)
    }
}

