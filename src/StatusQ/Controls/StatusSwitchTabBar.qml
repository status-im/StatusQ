import QtQuick 2.14
import QtQuick.Controls 2.14
import StatusQ.Core.Theme 0.1

TabBar {
    id: control
    padding: 1

    background: Rectangle {
        implicitHeight: 36
        color: Theme.palette.directColor7
        radius: 8
        border.width: 1
        border.color: color
    }
}
