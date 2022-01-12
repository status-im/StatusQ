import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Column {
    id: statusBanner
    width: parent.width

    property string statusText
    property int type: StatusBanner.Type.Info
    property int textPixels: 15
    property int statusBannerHeight: 38

    // "private" properties
    QtObject {
           id: pProp
           property color backgroundColor
           property color bordersColor
           property color fontColor
    }

    enum Type {
        None, // 0
        Info, // 1
        Danger, // 2
        Success, // 3
        Warning // 4
    }

    function setBannerBackgroundColor() {
        if(statusBanner.type === StatusBanner.Type.Info) {
            pProp.backgroundColor = Theme.palette.primaryColor3
            pProp.bordersColor = Theme.palette.primaryColor2
            pProp.fontColor = Theme.palette.primaryColor1
        }
        else if(statusBanner.type === StatusBanner.Type.Danger) {
            pProp.backgroundColor = Theme.palette.dangerColor3
            pProp.bordersColor = Theme.palette.dangerColor2
            pProp.fontColor = Theme.palette.dangerColor1
        }
        else if(statusBanner.type === StatusBanner.Type.Success) {
            pProp.backgroundColor = Theme.palette.successColor2
            pProp.bordersColor = Theme.palette.successColor3
            pProp.fontColor = Theme.palette.successColor1
        }
        else if(statusBanner.type === StatusBanner.Type.Warning) {
            pProp.backgroundColor = Theme.palette.pinColor3
            pProp.bordersColor = Theme.palette.pinColor2
            pProp.fontColor = Theme.palette.pinColor1
        }
    }

    onTypeChanged: setBannerBackgroundColor()

    // Component definition
    Rectangle {
        id: topDiv
        color: pProp.bordersColor
        height: 1
        width: parent.width
    }

    Rectangle {
        id: box
        width: parent.width
        height: statusBanner.statusBannerHeight
        color: pProp.backgroundColor

        StatusBaseText {
            id: statusTxt
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: statusBanner.textPixels
            text: statusBanner.statusText
            color: pProp.fontColor
        }
    }

    Rectangle {
        id: bottomDiv
        color: pProp.bordersColor
        height: 1
        width: parent.width
    }
}
