import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Core 0.1

Action {
    id: statusMenuItem

    enum Type {
        Normal,
        Danger
    }
    icon.color: "transparent"
    property int type: StatusMenuItem.Type.Normal
    property real iconRotation: 0
    property StatusAssetSettings assetSettings: StatusAssetSettings {
        isLetterIdenticon: false
        color: "transparent"
        imgHeight: 16
        imgWidth: 16
        imgIsIdenticon: false
    }

    property StatusFontSettings fontSettings: StatusFontSettings {}
}
