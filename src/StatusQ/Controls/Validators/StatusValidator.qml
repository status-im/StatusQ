import QtQuick 2.13
import StatusQ.Controls 0.1

QtObject {
    id: statusValidator

    property string name: ""
    property string errorMessage: qsTr("invalid input")
    property var validatorObj

    property var validate: function (value) {
        return true
    }
}
