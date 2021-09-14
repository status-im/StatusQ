import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Controls.Validators 0.1

Item {
    id: root
    implicitWidth: 480
    height: (label.visible ?
                  label.anchors.topMargin +
                  label.height :
              charLimitLabel.visible ?
                  charLimitLabel.anchors.topMargin +
                  charLimitLabel.height :
              0) +
            statusBaseInput.anchors.topMargin +
            statusBaseInput.height +
            (errorMessage.visible ?
                  errorMessage.anchors.topMargin +
                  errorMessage.height :
                  0) + 8

    property alias input: statusBaseInput
    property alias valid: statusBaseInput.valid
    property alias pending: statusBaseInput.pending
    property alias text: statusBaseInput.text
    property string label: ""
    property string secondaryLabel: ""
    property int charLimit: 0
    property string errorMessage: ""
    property real leftPadding: 16
    property real rightPadding: 16
    property list<StatusValidator> validators
    property list<StatusValidator> asyncValidators
    property int validationMode: StatusInput.ValidationMode.OnlyWhenDirty

    property var pendingValidators: []

    enum ValidationMode {
        OnlyWhenDirty, // validates input only after it has become dirty
        Always // validates input even before it has become dirty
    }

    property var errors: ({})
    property var asyncErrors: ({})

    function reset() {
        statusBaseInput.valid = false
        statusBaseInput.pristine = true
        statusBaseInput.text = ""
        errorMessage = ""
    }

    function validate() {
        if (!statusBaseInput.dirty && validationMode === StatusInput.ValidationMode.OnlyWhenDirty) {
            return
        }
        statusBaseInput.valid = true
        if (validators.length) {
            for (let idx in validators) {
                let validator = validators[idx]
                let result = validator.validate(statusBaseInput.text)

                if (typeof result === "boolean" && result) {
                    statusBaseInput.valid = statusBaseInput.valid && true
                    delete errors[validator.name]
                } else {
                    if (!errors) {
                        errors = {}
                    }
                    result.errorMessage = validator.errorMessage
                    errors[validator.name] = result
                    statusBaseInput.valid = statusBaseInput.valid && false
                }
            }
            if (errors){
                let errs = Object.values(errors)
                if (errs && errs[0]) {
                    errorMessage.text = errs[0].errorMessage || root.errorMessage;
                } else {
                    errorMessage.text = ""
                }
            }
        }

        if (asyncValidators.length && !Object.values(errors).length) {
            root.pending = true
            for (let idx in asyncValidators) {
                let asyncValidator = asyncValidators[idx]
                if (pendingValidators.indexOf(asyncValidator.name) == -1) {
                    asyncValidator.input = root
                    pendingValidators.push(asyncValidator.name)
                    asyncValidator.validate(statusBaseInput.text)
                }
            }
        }
    }

    function updateValidity(validatorName, result) {
        if (!asyncErrors) {
            asyncErrors = {}
        }

        if (typeof result === "boolean" && result) {
            if (asyncErrors[validatorName] !== undefined) {
                delete asyncErrors[validatorName]
            }
            errorMessage.text = ""
        } else {
            asyncErrors[validatorName] = result
            for (let idx in asyncValidators) {
                errorMessage.text = asyncValidators[idx].errorMessage || root.errorMessage
                break;
            }
        }
        pendingValidators = pendingValidators.filter(v => v !== validatorName)
        root.pending = pendingValidators.length > 0
        root.valid = Object.values(asyncErrors).length == 0
    }

    Component.onCompleted: validate()

    Row {
        id: labelRow
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: visible ? 8 : 0
        anchors.leftMargin: root.leftPadding
        anchors.right: (charLimitLabel.visible ? charLimitLabel.right : parent.right)
        anchors.rightMargin: root.rightPadding
        height: visible ? 17 : 0
        visible: !!root.label
        spacing: 5
        StatusBaseText {
            id: label
            elide: Text.ElideRight
            text: root.label
            font.pixelSize: 15
            color: statusBaseInput.enabled ? Theme.palette.directColor1 : Theme.palette.baseColor1
        }

        StatusBaseText {
            id: secondaryLabel
            height: visible ? 17 : 0
            visible: !!root.secondaryLabel
            elide: Text.ElideRight
            text: root.secondaryLabel
            font.pixelSize: 15
            color: Theme.palette.baseColor1
        }
    }

    StatusBaseText {
        id: charLimitLabel
        height: visible ? implicitHeight : 0
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: visible ? 11 : 0
        anchors.rightMargin: root.rightPadding
        visible: root.charLimit > 0

        text: "%1 / %2".arg(statusBaseInput.text.length).arg(root.charLimit)
        font.pixelSize: 12
        color: statusBaseInput.enabled ? Theme.palette.baseColor1 : Theme.palette.directColor6
    }

    StatusBaseInput {
        id: statusBaseInput
        anchors.top:  labelRow.visible ? labelRow.bottom :
                charLimitLabel.visible ? charLimitLabel.bottom : parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: charLimitLabel.visible ? 11 : 8
        anchors.leftMargin: root.leftPadding
        anchors.rightMargin: root.rightPadding
        maximumLength: root.charLimit
        onTextChanged: root.validate()

        Keys.forwardTo: [root]
    }

    StatusBaseText {
        id: errorMessage

        anchors.top: statusBaseInput.bottom
        anchors.topMargin: 11
        anchors.right: parent.right
        anchors.rightMargin: root.rightPadding
        anchors.left: parent.left
        anchors.leftMargin: root.leftPadding

        height: visible ? implicitHeight : 0
        visible: !!text && !statusBaseInput.valid

        font.pixelSize: 12
        color: Theme.palette.dangerColor1


        horizontalAlignment: Text.AlignRight
        wrapMode: Text.WordWrap
    }
}
