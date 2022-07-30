import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Controls 0.1

StatusComboBox {
    id: root

    label: qsTr("Color")

    control.popup.horizontalPadding: 0

    contentItem: Item { }

    control.background: Rectangle {
        implicitWidth: 448
        radius: 8
        color: root.control.currentValue
    }

    delegate: Rectangle {
        width: parent.width
        implicitHeight: 52
        color: modelData
    }
}

