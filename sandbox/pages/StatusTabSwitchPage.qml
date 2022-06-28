import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.13

import StatusQ.Controls 0.1
import StatusQ.Core.Theme 0.1

GridLayout {
    columns: 1
    columnSpacing: Theme.dp(5)
    rowSpacing: Theme.dp(5)

    StatusSwitchTabBar {
        StatusSwitchTabButton {
            text: "Swap"
        }
        StatusSwitchTabButton {
            text: "Swap & Send"
        }
        StatusSwitchTabButton {
            text: "Send"
        }
    }
}

