import StatusQ.Controls 0.1

StatusValidator {

    property int minLength: 0
    property string fieldName: "value"

    name: "minLength"

    error: {
        minLength === 1 ?
            qsTr("You need to enter a %1").arg(fieldName) :
            qsTr("Value has to be at least %1 characters long").arg(minLength)
    }

    validate: function (value) {
        return value.length >= minLength ? true : {
            min: minLength,
            actual: value.length
        }
    }
}

