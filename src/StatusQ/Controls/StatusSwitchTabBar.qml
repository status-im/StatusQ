import QtQuick 2.14
import QtQuick.Controls 2.14
import StatusQ.Core.Theme 0.1

TabBar {
    id: statusSwitchTabBar
    padding: Theme.dp(1)

    background: Rectangle {
        implicitHeight: Theme.dp(36)
        color: Theme.palette.statusSwitchTab.barBackgroundColor
        radius: Theme.dp(8)
    }
}
