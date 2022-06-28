import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Controls.Validators 0.1

import Sandbox 0.1

Column {
    spacing: Theme.dp(8)

    StatusInput {
        input.placeholderText: "Placeholder"
    }

    StatusInput {
        label: "Label"
        input.placeholderText: "Disabled"
        input.enabled: false
    }

    StatusInput {
        input.placeholderText: "Clearable"
        input.clearable: true
    }

    StatusInput {
        input.placeholderText: "Invalid"
        input.valid: false
    }

    StatusInput {
        label: "Label"

        input.icon.name: "search"
        input.placeholderText: "Input with icon"
    }

    StatusInput {
        label: "Label"
        input.placeholderText: "Placeholder"
        input.clearable: true
    }

    StatusInput {
        charLimit: 30
        input.placeholderText: "Placeholder"
        input.clearable: true
    }

    StatusInput {
        label: "Label"
        charLimit: 30
        input.placeholderText: "Placeholder"
        input.clearable: true
    }

    Item {
        implicitWidth: Theme.dp(480)
        implicitHeight: Theme.dp(82)
        z: 100000
        StatusSeedPhraseInput {
            id: statusSeedInput
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height
            textEdit.input.anchors.leftMargin: Theme.dp(16)
            textEdit.input.anchors.rightMargin: Theme.dp(16)
            textEdit.input.anchors.topMargin: Theme.dp(11)
            textEdit.label: "Input with drop down selection list"
            leftComponentText: "1"
            inputList: ListModel {
                ListElement {
                    seedWord: "panda"
                }
                ListElement {
                    seedWord: "posible"
                }
                ListElement {
                    seedWord: "wing"
                }
            }
        }
    }

    StatusInput {
        label: "Label"
        charLimit: 30
        errorMessage: "Error message"
        input.clearable: true
        input.valid: false
        input.placeholderText: "Placeholder"
    }

    StatusInput {
        label: "StatusInput"
        secondaryLabel: "with right icon"
        input.icon.width: Theme.dp(15)
        input.icon.height: Theme.dp(11)
        input.icon.name: text !== "" ? "checkmark" : ""
        input.leftIcon: false
    }

    StatusInput {
        label: "Label"
        secondaryLabel: "secondary label"
        input.placeholderText: "Placeholder"
        input.implicitHeight: Theme.dp(56)
    }

    StatusInput {
        id: input
        label: "Label"
        charLimit: 30
        input.placeholderText: "Input with validator"

        validators: [
            StatusMinLengthValidator {
                minLength: 10
                errorMessage: {
                    if (input.errors && input.errors.minLength) {
                        return `Value can't be shorter than ${input.errors.minLength.min} but got ${input.errors.minLength.actual}`
                    }
                    return ""
                }
            }
        ]
    }

    StatusInput {
        label: "Input with <i>StatusRegularExpressionValidator</i>"
        charLimit: 30
        input.placeholderText: `Must match regex(${validators[0].regularExpression.toString()}) and <= 30 chars`
        validationMode: StatusInput.ValidationMode.IgnoreInvalidInput

        validators: [
            StatusRegularExpressionValidator {
                regularExpression: /^[0-9A-Za-z_\$-\s]*$/
                errorMessage: "Bad input!"
            }
        ]
    }

    StatusInput {
        label: "Label"
        input.placeholderText: "Input width component (right side)"
        input.rightComponent: StatusIcon {
            icon: "cancel"
            height: Theme.dp(16)
            color: Theme.palette.dangerColor1
        }
    }


    StatusInput {
        input.multiline: true
        input.placeholderText: "Multiline"
    }

    StatusInput {
        input.multiline: true
        input.placeholderText: "Multiline with static height"
        input.implicitHeight: Theme.dp(100)
    }

    StatusInput {
        input.multiline: true
        input.placeholderText: "Multiline with max/min"
        input.minimumHeight: Theme.dp(80)
        input.maximumHeight: Theme.dp(200)
    }

    StatusInput {
        property bool toggled: true
        label: "Input with emoji icon"
        input.placeholderText: "Enter Name"
        input.icon.emoji: toggled ? "😁" : "🧸"
        input.icon.color: "blue"
        input.isIconSelectable: true
        onIconClicked: {
            toggled = !toggled
        }
    }

    StatusInput {
        property bool toggled: true
        label: "Input with selectable icon which is not an emoji"
        input.placeholderText: "Enter Name"
        input.icon.emoji: ""
        input.icon.name: toggled ? "filled-account" : "image"
        input.icon.color: "blue"
        input.isIconSelectable: true
        onIconClicked: {
            toggled = !toggled
        }
    }

    StatusInput {
        label: "Input with inline token selector"
        input.leftComponent: StatusTokenInlineSelector {
            anchors.verticalCenter: parent.verticalCenter
            tokens: [{amount: 0.1, token: "ETH"},
                     {amount: 10, token: "SNT"},
                     {amount: 15, token: "MANA"}]

            StatusToolTip {
                id: toolTip
                text: "posted"
            }
            onTriggered: toolTip.visible = true
        }
        input.edit.readOnly: true
    }
}
