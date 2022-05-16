import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1

Rectangle {
    id: root

    property alias identiconText: identiconText
    property string name
    property string emoji
    property string emojiSize: Emoji.size.small
    property int letterSize: 21
    property int charactersLen: 1
    readonly property string emojiId: Emoji.iconId(emoji, emojiSize) || ""

    color: Theme.palette.miscColor5
    width: 40
    height: 40
    radius: width / 2

    Image {
        id: emojiImage
        
        visible: root.emoji
        anchors.centerIn: parent
        width: Math.round(parent.width / 2)
        height: Math.round(parent.height / 2)
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectFit
        mipmap: true
        antialiasing: true
        source: root.emojiId ? `../../assets/twemoji/svg/${root.emojiId}.svg` : ""
    }
    
    StatusBaseText {
        id: identiconText

        visible: !root.emoji
        anchors.alignWhenCentered: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: parent.width
        height: parent.height

        font.weight: Font.Bold
        font.pixelSize: root.letterSize
        color: d.luminance(root.color) > 0.5 ? Qt.rgba(0, 0, 0, 0.5) : Qt.rgba(255, 255, 255, 0.7)

        text: {
            const shift = (root.name.charAt(0) === "#") ||
                          (root.name.charAt(0) === "@")
            return root.name.substring(shift, shift + charactersLen).toUpperCase()
        }
    }

    QtObject {
        id: d
        function luminance(color) {
            let r = Math.pow(color.r, 2.2) * 0.2126
            let g = Math.pow(color.g, 2.2) * 0.7151
            let b = Math.pow(color.b, 2.2) * 0.0721
            return r + g + b
        }
    }
}

