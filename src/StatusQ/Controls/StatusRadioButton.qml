import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQml 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1


RadioButton {
    id: statusRadioButton

    width: indicator.implicitWidth

    indicator: Rectangle {
        implicitWidth: Theme.dp(20)
        implicitHeight: Theme.dp(20)
        x: 0
        y: 6
        radius: Theme.dp(10)
        color: statusRadioButton.checked ? Theme.palette.primaryColor1
                                         : Theme.palette.directColor8

        Rectangle {
            width: Theme.dp(12)
            height: Theme.dp(12)
            radius: Theme.dp(6)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: statusRadioButton.checked ? Theme.palette.white : "transparent"
            visible: statusRadioButton.checked
        }
    }
    contentItem: StatusBaseText {
        text: statusRadioButton.text
        color: Theme.palette.directColor1
        verticalAlignment: Text.AlignVCenter
        leftPadding: !!statusRadioButton.text ? statusRadioButton.indicator.width + statusRadioButton.spacing
                                              : statusRadioButton.indicator.width
    }
}
