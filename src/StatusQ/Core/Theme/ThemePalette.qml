import QtQuick 2.13

QtObject {
    
    id: theme

    property FontLoader baseFont
    property FontLoader baseFontThin
    property FontLoader baseFontExtraLight
    property FontLoader baseFontLight
    property FontLoader baseFontMedium
    property FontLoader baseFontBold
    property FontLoader baseFontExtraBold
    property FontLoader baseFontBlack

    property FontLoader monoFont
    property FontLoader monoFontThin
    property FontLoader monoFontExtraLight
    property FontLoader monoFontLight
    property FontLoader monoFontMedium
    property FontLoader monoFontBold
    property FontLoader monoFontExtraBold
    property FontLoader monoFontBlack

    property color black: getColor('black')
    property color white: getColor('white')

    property color dropShadow: getColor('black', 0.12)

    property color baseColor1
    property color baseColor2
    property color baseColor3
    property color baseColor4
    property color baseColor5

    property color primaryColor1
    property color primaryColor2
    property color primaryColor3

    property color dangerColor1
    property color dangerColor2
    property color dangerColor3

    property color successColor1
    property color successColor2

    property color mentionColor1
    property color mentionColor2
    property color mentionColor3
    property color mentionColor4

    property color pinColor1
    property color pinColor2
    property color pinColor3

    property color directColor1
    property color directColor2
    property color directColor3
    property color directColor4
    property color directColor5
    property color directColor6
    property color directColor7
    property color directColor8

    property color indirectColor1
    property color indirectColor2
    property color indirectColor3

    property color miscColor1
    property color miscColor2
    property color miscColor3
    property color miscColor4
    property color miscColor5
    property color miscColor6
    property color miscColor7
    property color miscColor8
    property color miscColor9
    property color miscColor10
    property color miscColor11

    property QtObject statusAppNavBar: QtObject {
        property color backgroundColor
    }

    function alphaColor(color, alpha) {
        let actualColor = Qt.darker(color, 1)
        actualColor.a = alpha
        return actualColor
    }

    function getColor(name, alpha) {
        return !!alpha ? alphaColor(StatusColors.colors[name], alpha) : StatusColors.colors[name]
    }
}

