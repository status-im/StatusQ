import QtQuick 2.14
import QtQuick.Controls 2.14

import StatusQ.Controls 0.1

ScrollView {
    id: root

    clip: true // NOTE: in Qt6 clip true will be default
    background: null

    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
    ScrollBar.vertical.policy: ScrollBar.AsNeeded

    Flickable {
        id: flickable

        contentWidth: contentItem.childrenRect.width
        contentHeight: contentItem.childrenRect.height
        boundsBehavior: Flickable.StopAtBounds
        maximumFlickVelocity: 0
        synchronousDrag: true
    }
}
