import QtQuick 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

QtObject {
    id: msgDetails

    property bool amISender: false
    property string displayName: ""
    property string secondaryName: ""
    property string chatID: ""
    property StatusImageSettings profileImage: StatusImageSettings {
        width: Theme.dp(40)
        height: Theme.dp(40)
    }
    property bool isEdited: false
    property string messageText: ""
    property int contentType: 0
    property string messageContent: ""
    property bool isMutualContact: false
    property var trustIndicator: StatusContactVerificationIcons.TrustedType.None
    property bool hasMention: false
    property bool isPinned: false
    property string pinnedBy: ""
    property bool hasExpired: false
    property string timestamp: ""    
}


