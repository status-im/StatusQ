import QtQuick 2.14
import QtQuick.Layouts 1.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

GridLayout {
    columns: 6
    columnSpacing: Theme.dp(5)
    rowSpacing: Theme.dp(5)
    property color iconColor

    Repeater {
        model: ["activity", "add-circle", "add-contact", "add",
            "address", "admin", "airdrop", "animals-and-nature",
            "browser", "arbitrator", "camera", "chat", "channel",
        "chatbot", "checkmark", "clear", "code", "communities"]

        delegate: StatusIcon {
            icon: modelData
            color: iconColor
        }
    }
}
