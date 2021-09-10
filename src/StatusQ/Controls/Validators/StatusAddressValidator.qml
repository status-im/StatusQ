import StatusQ.Controls 0.1
import StatusQ.Core.Utils 0.1

StatusValidator {
    name: "address"

    errorMessage: "Please enter a valid address"

    validate: function (t) {
        // TODO: Add ENS name resolution and validation a la
        // `ui/shared/AddressInput.qml`
        return Utils.isValidAddress(t) ? true : { actual: t }
    }
}

