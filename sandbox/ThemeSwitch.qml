import QtQuick 2.14
import QtQuick.Controls 2.14

import StatusQ.Controls 0.1
import StatusQ.Core.Theme 0.1

Item {
    id: themeSwitchWrapper
    signal checkedChanged()

    property alias lightThemeEnabled: switchControl.checked

    width: themeSwitch.width
    height: themeSwitch.height

    MouseArea {
        id: sensor
        hoverEnabled: true
        anchors.fill: parent

        Row {
            id: themeSwitch
            spacing: Theme.dp(2)

            Text {
                text: "🌤"
                font.pixelSize: Theme.dp(15)
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusSwitch {
                id: switchControl
                onCheckedChanged: themeSwitchWrapper.checkedChanged()

                StatusToolTip {
                    text: "Toggle Theme"
                    visible: sensor.containsMouse
                    orientation: StatusToolTip.Orientation.Bottom
                    y: themeSwitchWrapper.y + Theme.dp(16)
                }
            }

            Text {
                text: "🌙"
                font.pixelSize: Theme.dp(15)
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
