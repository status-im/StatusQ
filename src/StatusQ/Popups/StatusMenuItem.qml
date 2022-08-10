import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Core 0.1

Action {
    id: statusMenuItem

    enum Type {
        Normal,
        Danger
    }

    property int type: StatusMenuItem.Type.Normal
    property real iconRotation: 0

    // TODO: Rename to "imageSettings"
    property StatusImageSettings image: StatusImageSettings {
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

    icon.color: "transparent"
}
