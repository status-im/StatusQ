import QtQuick 2.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

StatusBaseButton {
    id: statusFlatButton

    normalColor: "transparent"
    hoverColor:  type === StatusBaseButton.Type.Normal ? Theme.palette.primaryColor3
                                                       : Theme.palette.dangerColor3
    disabledColor: "transparent"

    textColor: type === StatusBaseButton.Type.Normal ? Theme.palette.primaryColor1
                                                     : Theme.palette.dangerColor1
    disabledTextColor: Theme.palette.baseColor1

    borderColor: type === StatusBaseButton.Type.Normal || hovered ? "transparent"
                                                          : Theme.palette.baseColor2
    rightPadding: icon.name !== "" ? 18 : rightPadding
    leftPadding: icon.name !== "" ? 14 : leftPadding
}
