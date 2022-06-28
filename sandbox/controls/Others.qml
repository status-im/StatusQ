import QtQuick 2.14
import QtQuick.Layouts 1.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

ColumnLayout {
    GridLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true

        columns: 6
        columnSpacing: Theme.dp(5)
        rowSpacing: Theme.dp(5)

        StatusLoadingIndicator {
            color: Theme.palette.directColor4
        }

        StatusLetterIdenticon {
            name: "#status"
        }

        StatusRoundedImage {
            image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
        }

        StatusBadge {}

        StatusBadge {
            value: 1
        }

        StatusBadge {
            value: 10
        }

        StatusBadge {
            value: 100
        }

        StatusRoundIcon {
            icon.name: "info"
        }
    }

    Flow {
        Layout.fillWidth: true
        spacing: 4

        Repeater {
            model: 12
            StatusLetterIdenticon {
                name: "A"
                color: Theme.palette.userCustomizationColors[index]
                letterSize: Theme.dp(16)
            }
        }
    }
}

