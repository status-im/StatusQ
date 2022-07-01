import QtQuick 2.13
import QtQuick.Controls 2.14

import StatusQ.Core.Theme 0.1

RadioButton {
    id: control

    property string radioButtonColor: ""
    property string selectionColor: StatusColors.colors['white']

    spacing: 0

    implicitWidth: 44
    implicitHeight: 44

    indicator: Rectangle {
        implicitWidth: 44
        implicitHeight: 44
        radius: width / 2
        color: radioButtonColor

        Rectangle {
            anchors.centerIn: parent
            visible: control.checked
            width: 16
            height: 16
            radius: width / 2
            color: selectionColor
            border.color: StatusColors.colors['grey3']
        }
    }
}

