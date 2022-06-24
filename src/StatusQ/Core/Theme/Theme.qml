pragma Singleton
import QtQuick.Window 2.14

import QtQuick 2.13

QtObject {
    id: appTheme
    property QtObject palette: StatusLightTheme {}

    readonly property int screenWidth: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.width
                                                                                              :  1224
    readonly property int screenHeight: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.height
                                                                                               :840
    function setTheme(theme) {
        palette = theme
    }

    function isHtml(text) {
        return (/<\/?[a-z][\s\S]*>/i.test(text))
    }

    property real scaleFactor: 1.0
    function dp(value) {
        return (value * scaleFactor);
    }
}


