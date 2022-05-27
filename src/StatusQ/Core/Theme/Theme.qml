pragma Singleton

import QtQuick 2.13

QtObject {
    id: appTheme
    property QtObject palette: StatusLightTheme {}

    property int bigPadding: 24
    property int radius: 8

    function setTheme(theme) {
        palette = theme
    }
}


