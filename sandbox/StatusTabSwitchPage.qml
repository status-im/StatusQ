import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.13

import StatusQ.Controls 0.1

GridLayout {
    columns: 1
    columnSpacing: 5
    rowSpacing: 5

    StatusSwitchTabBar {
        StatusSwitchTab {
            text: "Swap"
        }
        StatusSwitchTab {
            text: "Swap & Send"
        }
        StatusSwitchTab {
            text: "Send"
        }
    }
}

