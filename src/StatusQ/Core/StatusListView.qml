import QtQuick 2.14
import QtQuick.Controls 2.14

ListView {
    id: root

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    maximumFlickVelocity: 0
    synchronousDrag: true
}