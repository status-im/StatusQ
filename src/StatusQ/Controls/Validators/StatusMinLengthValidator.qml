import StatusQ.Controls 0.1

StatusValidator {

    property int minLength: 0

    name: "minLength"

    errorMessage: {
        minLength === 1 ?
            "Please enter a value" :
            `Value is ${errors.address.actual} characters, but must be at least ${minLength}.`
    }

    validate: function (value) {
        return value.length >= minLength ? true : {
            min: minLength,
            actual: value.length
        }
    }
}

