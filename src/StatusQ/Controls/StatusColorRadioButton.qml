import QtQuick 2.13
import QtQuick.Controls 2.14

import StatusQ.Core.Theme 0.1

RadioButton {
    id: control

    property string radioButtonColor: ""
    property string selectionColor: StatusColors.colors['white']

    implicitWidth: Theme.dp(48)
    implicitHeight: Theme.dp(48)

    indicator: Rectangle {
        implicitWidth: Theme.dp(48)
        implicitHeight: Theme.dp(48)
        radius: width/2
        color: radioButtonColor

        Rectangle {
            width: Theme.dp(20)
            height: Theme.dp(20)
            radius: width/2
            color: selectionColor
            border.color: StatusColors.colors['grey3']
            visible: control.checked
            anchors.centerIn: parent
        }
    }
}

