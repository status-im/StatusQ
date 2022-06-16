import QtQuick 2.14
import QtQuick.Layouts 1.14

StackLayout {
    id: root

    property int previousIndex: 0
    property int duration: 300

    property var items: children

    readonly property var previousItem: items[previousIndex]
    readonly property var currentItem: items[currentIndex]

    clip: true

    Component.onCompleted: {
        previousIndex = currentIndex

        for(var i = 1; i < count; ++i) {
            children[i].opacity = 0
        }
    }

    Component {
        id: crossFader

        ParallelAnimation {
            property Item fadeOutTarget
            property Item fadeInTarget
            readonly property bool direct: previousIndex < currentIndex

            NumberAnimation {
                target: fadeOutTarget
                property: "opacity"
                to: 0
                duration: root.duration
            }

            NumberAnimation {
                target: fadeInTarget
                property: "opacity"
                to: 1
                duration: root.duration
            }

            NumberAnimation {
                target: fadeOutTarget
                property: "x"
                from: 0
                to: direct ? -root.width : root.width
                duration: root.duration
            }

            NumberAnimation {
                target: fadeInTarget
                property: "x"
                from: direct ? root.width : -root.width
                to: 0
                duration: root.duration
            }
        }
    }

    onCurrentIndexChanged: {
        items = root.children;

        if (previousItem && currentItem && (previousItem != currentItem)) {
            previousItem.visible = true;
            currentItem.visible = true;
            var crossFaderAnim = crossFader.createObject(parent,
            {
                fadeOutTarget: previousItem,
                fadeInTarget: currentItem
            });
            crossFaderAnim.restart();
        }
        previousIndex = currentIndex;
    }
}