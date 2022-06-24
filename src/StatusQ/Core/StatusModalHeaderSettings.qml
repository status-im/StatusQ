import QtQuick 2.14

import StatusQ.Core.Theme 0.1

QtObject {
    property string title
    property string subTitle
    property int titleElide: Text.ElideRight
    property int subTitleElide: Text.ElideRight
    property bool headerImageEditable: false
    property bool editable: false
    property Component popupMenu
    property StatusImageSettings image: StatusImageSettings {
        width: Theme.dp(40)
        height: Theme.dp(40)
        isIdenticon: false
    }

    property StatusIconSettings icon: StatusIconSettings {
        width: Theme.dp(40)
        height: Theme.dp(40)
        isLetterIdenticon: false
    }
}
