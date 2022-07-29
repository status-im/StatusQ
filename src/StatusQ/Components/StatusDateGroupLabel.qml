import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

StatusBaseText {
    id: root

    property int previousMessageIndex: -1
    property string previousMessageTimestamp
    property string messageTimestamp

    font.pixelSize: 13
    color: Theme.palette.baseColor1
    horizontalAlignment: Text.AlignHCenter

    text: {
        if (previousMessageIndex === -1)
            return ""; // identifier

        const now = new Date()
        const yesterday = new Date()
        yesterday.setDate(now.getDate()-1)

        const currentMsgDate = new Date(parseInt(messageTimestamp, 10));
        const prevMsgDate = previousMessageTimestamp === "" ? undefined
                                                            : new Date(parseInt(previousMessageTimestamp, 10));

        if (!!prevMsgDate && currentMsgDate.getDay() === prevMsgDate.getDay())
            return "";

        if (now.toDateString() === currentMsgDate.toDateString())
            return qsTr("Today");

        if (yesterday.toDateString() === currentMsgDate.toDateString())
            return qsTr("Yesterday");

        const monthNames = [
                             qsTr("January"),
                             qsTr("February"),
                             qsTr("March"),
                             qsTr("April"),
                             qsTr("May"),
                             qsTr("June"),
                             qsTr("July"),
                             qsTr("August"),
                             qsTr("September"),
                             qsTr("October"),
                             qsTr("November"),
                             qsTr("December")
                         ];

        return monthNames[currentMsgDate.getMonth()] + ", " + currentMsgDate.getDate();
    }
}
