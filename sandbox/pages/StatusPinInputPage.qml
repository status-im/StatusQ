import QtQuick 2.14
import QtQuick.Layouts 1.14

import StatusQ.Core.Theme 0.1
import StatusQ.Core 0.1
import StatusQ.Controls 0.1
import StatusQ.Controls.Validators 0.1

Column {
    id: root
    spacing: Theme.dp(25)
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

    // PIN input that accepts only numbers
    StatusBaseText {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.directColor1
        text: "Enter Keycard PIN"
        font.pixelSize: Theme.dp(30)
        font.bold: true
    }

    StatusPinInput {
        id: numbersPinInput
        anchors.horizontalCenter: parent.horizontalCenter
        validator: StatusIntValidator{bottom: 0; top: 999999;}
    }

    StatusBaseText {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.dangerColor1
        text: "Only numbers allowed"
        font.pixelSize: Theme.dp(16)
    }

    StatusBaseText {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.directColor1
        text: "Introduced PIN: " + numbersPinInput.pinInput
        font.pixelSize: Theme.dp(12)
    }

    // PIN input that accepts input depending on the regular expression definition
    StatusBaseText {
        topPadding: Theme.dp(100)
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.directColor1
        text: "Enter another Keycard PIN"
        font.pixelSize: Theme.dp(30)
        font.bold: true
    }

    StatusPinInput {
        id: regexPinInput
        anchors.horizontalCenter: parent.horizontalCenter
        validator: StatusRegularExpressionValidator { regularExpression: /[0-9A-Za-z@]+/ }
        circleDiameter: Theme.dp(22)
        circleSpacing: Theme.dp(22)
        pinLen: 7
    }

    StatusBaseText {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.dangerColor1
        text: "Only alphanumeric characters and '@' allowed"
        font.pixelSize: Theme.dp(16)
    }

    StatusBaseText {
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.palette.directColor1
        text: "Introduced PIN: " + regexPinInput.pinInput
        font.pixelSize: Theme.dp(12)
    }
}
