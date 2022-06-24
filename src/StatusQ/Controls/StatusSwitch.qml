import QtQuick 2.12
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

Switch {
    id: statusSwitch

    indicator: Rectangle {
        id: oval
        implicitWidth: Theme.dp(52)
        implicitHeight: Theme.dp(28)
        x: statusSwitch.leftPadding
        y: parent.height / 2 - height / 2
        radius: 14
        color: statusSwitch.checked ? Theme.palette.primaryColor1
                               : Theme.palette.directColor8


        Rectangle {
            id: circle
            y: Theme.dp(4)
            width: Theme.dp(20)
            height: Theme.dp(20)
            radius: Theme.dp(10)
            color: Theme.palette.white
            layer.enabled: true
            layer.effect: DropShadow {
                width: parent.width
                height: parent.height
                visible: true
                verticalOffset: Theme.dp(1)
                fast: true
                cached: true
                color: Theme.palette.dropShadow
            }

            states: [
                State {
                    name: "on"
                    when: statusSwitch.checked
                    PropertyChanges { target: circle; x: oval.width - circle.width - 4 }
                },
                State {
                    name: "off"
                    when: !statusSwitch.checked
                    PropertyChanges { target: circle; x: 4 }
                }
            ]

            transitions: Transition {
                reversible: true
                NumberAnimation { properties: "x"; easing.type: Easing.Linear; duration: 120; }
            }
        }
    }

    contentItem: StatusBaseText {
        text: statusSwitch.text
        opacity: enabled ? 1.0 : 0.3
        verticalAlignment: Text.AlignVCenter
        leftPadding: !!statusSwitch.text ? statusSwitch.indicator.width + statusSwitch.spacing : statusSwitch.indicator.width
    }
}
