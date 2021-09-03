import QtQuick 2.14

import QtQuick.Controls 2.14 as QC

import StatusQ.Controls 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1


Item {
    id: statusBaseInput

    property bool multiline: false

    property bool clearable: false

    property alias inputMethodHints: edit.inputMethodHints

    property alias selectedText: edit.selectedText
    property alias selectedTextColor: edit.selectedTextColor
    property alias selectionStart: edit.selectionStart
    property alias selectionEnd: edit.selectionEnd
    property alias cursorPosition: edit.cursorPosition

    property alias text: edit.text

    property alias color: edit.color
    property alias font: edit.font
    property alias focussed: edit.activeFocus
    property alias verticalAlignmet: edit.verticalAlignment
    property alias horizontalAlignment: edit.horizontalAlignment

    property alias placeholderText: placeholder.text
    property alias placeholderTextColor: placeholder.color
    property alias placeholderFont: placeholder.font

    property real leftPadding: 16
    property real rightPadding: 16
    property real topPadding: 12
    property real bottomPadding: 12

    property real minimumHeight: 0
    property real maximumHeight: 0
    property int maximumLength: 0

    property bool valid: true
    property bool pristine: true
    property bool dirty: false
    property bool leftIcon: true

    property StatusIconSettings icon: StatusIconSettings {
        width: 24
        height: 24
        name: ""
        color: Theme.palette.baseColor1
    }

    implicitWidth: 448
    implicitHeight: multiline ? Math.max((edit.implicitHeight + topPadding + bottomPadding), 44) : 44

    Rectangle {
        width: parent.width
        height: maximumHeight != 0 ? Math.min(
                                         minimumHeight != 0 ? Math.max(statusBaseInput.implicitHeight, minimumHeight)
                                         : statusBaseInput.implicitHeight, maximumHeight) : parent.height
        color: Theme.palette.baseColor2
        radius: 8

        clip: true

        border.width: 1
        border.color: {
            if (!statusBaseInput.valid && statusBaseInput.dirty) {
                return Theme.palette.dangerColor1;
            }
            if (edit.activeFocus) {
                return Theme.palette.primaryColor1;
            }
            return sensor.containsMouse ? Theme.palette.primaryColor2 : "transparent"
        }

        StatusIcon {
            id: statusIcon
            anchors.topMargin: 10
            anchors.left: statusBaseInput.leftIcon ? parent.left : undefined
            anchors.right: !statusBaseInput.leftIcon ? parent.right : undefined
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            icon: statusBaseInput.icon.name
            width: statusBaseInput.icon.width
            height: statusBaseInput.icon.height
            color: statusBaseInput.icon.color
            visible: !!statusBaseInput.icon.name
        }

        Flickable {
            id: flick
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: (statusIcon.visible && statusBaseInput.leftIcon) ?
                          statusIcon.right : parent.left
            anchors.right: (statusIcon.visible && !statusBaseInput.leftIcon) ?
                            statusIcon.left : parent.right
            anchors.leftMargin: statusIcon.visible && statusBaseInput.leftIcon ? 8
                                : statusBaseInput.leftPadding
            anchors.rightMargin: statusBaseInput.rightPadding + clearable ? clearButton.width
                                 : statusIcon.visible && !leftIcon ? 8: 0
            anchors.topMargin: statusBaseInput.topPadding
            anchors.bottomMargin: statusBaseInput.bottomPadding
            contentWidth: edit.paintedWidth
            contentHeight: edit.paintedHeight
            boundsBehavior: Flickable.StopAtBounds
            QC.ScrollBar.vertical: QC.ScrollBar { interactive: multiline; enabled: multiline }
            function ensureVisible(r) {
                if (contentX >= r.x)
                    contentX = r.x;
                else if (contentX+width <= r.x+r.width)
                    contentX = r.x+r.width-width;
                if (contentY >= r.y)
                    contentY = r.y;
                else if (contentY+height <= r.y+r.height)
                    contentY = r.y+r.height-height;
            }
            TextEdit {
                id: edit
                property string previousText: text
                width: flick.width
                height: flick.height
                verticalAlignment: Text.AlignVCenter
                selectByMouse: true
                selectionColor: Theme.palette.primaryColor2
                selectedTextColor: color
                focus: true
                font.pixelSize: 15
                font.family: Theme.palette.baseFont.name
                color: Theme.palette.directColor1
                onCursorRectangleChanged: { flick.ensureVisible(cursorRectangle); }
                wrapMode: statusBaseInput.multiline ? Text.WrapAtWordBoundaryOrAnywhere : TextEdit.NoWrap
                onActiveFocusChanged: {
                    if (statusBaseInput.pristine) {
                        statusBaseInput.pristine = false
                    }
                }

                Keys.onReturnPressed: {
                    if (multiline) {
                        event.accepted = false
                    } else {
                        event.accepted = true
                    }
                }

                Keys.onEnterPressed: {
                    if (multiline) {
                        event.accepted = false
                    } else {
                        event.accepted = true
                    }
                }

                Keys.forwardTo: [statusBaseInput]

                onTextChanged: {
                    statusBaseInput.dirty = true
                    if (statusBaseInput.maximumLength > 0) {
                        if (text.length > statusBaseInput.maximumLength) {
                            var cursor = cursorPosition;
                            text = previousText;
                            if (cursor > text.length) {
                                cursorPosition = text.length;
                            } else {
                                cursorPosition = cursor-1;
                            }
                        }
                        previousText = text
                    }
                }
                StatusBaseText {
                    id: placeholder
                    visible: (edit.text.length === 0)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: statusBaseInput.rightPadding
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 15
                    elide: StatusBaseText.ElideRight
                    font.family: Theme.palette.baseFont.name
                    color: statusBaseInput.enabled ? Theme.palette.baseColor1 :
                                                     Theme.palette.directColor6
                }
            }

        } // Flickable
        MouseArea {
            id: sensor
            enabled: !edit.activeFocus
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            onClicked: edit.forceActiveFocus()
        }

    } // Rectangle

    StatusFlatRoundButton {
        id: clearButton
        visible: edit.text.length != 0 &&
                 statusBaseInput.clearable &&
                 !statusBaseInput.multiline &&
                 edit.activeFocus
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        type: StatusFlatRoundButton.Type.Secondary
        width: 24
        height: 24
        icon.name: "clear"
        icon.width: 16
        icon.height: 16
        icon.color: Theme.palette.baseColor1
        onClicked: {
            edit.clear()
        }
    }

}
