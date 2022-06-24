import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Action {
    id: statusMenuItem

    enum Type {
        Normal,
        Danger
    }
    icon.color: "transparent"
    property int type: StatusMenuItem.Type.Normal
    property real iconRotation: 0
    property StatusImageSettings image: StatusImageSettings {
        height: Theme.dp(16)
        width: Theme.dp(16)
        isIdenticon: false
    }
    property StatusIconSettings iconSettings: StatusIconSettings {
        isLetterIdenticon: false
        background: StatusIconBackgroundSettings {}
        color: "transparent"
    }
}
