import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1
import StatusQ.Popups 0.1


StatusModal {
    id: root
    width: Theme.dp(700)
    height: (!!searchResults && (searchResults.count >= 0) && (searchText !== "")) ? (((searchResults.count < 5)) ? 560 : 770) : 142 //970
    anchors.centerIn: parent
    showHeader: false
    showFooter: false

    property string searchText: contentItem.searchText
    property string noResultsLabel: qsTr("No results")
    property string defaultSearchLocationText: qsTr("Anywhere")
    property bool loading: false
    property Menu searchOptionsPopupMenu: Menu { }
    property var searchResults: [ ]
    property var searchSelectionButton
    // This function is called to know if the popup accepts clicks in the title
    // If it does not, the clicks on the titles mousearea will be propagated to the main body instead
    property var acceptsTitleClick: function(titleId) {return true}

    signal resultItemClicked(string itemId)
    signal resultItemTitleClicked(string titleId)

    property var formatTimestampFn: function (ts) {
        return ts
    }

    function setSearchSelection(text = "",
                                secondaryText = "",
                                imageSource = "",
                                isIdenticon = "",
                                iconName = "",
                                iconColor = "",
                                isUserIcon = false,
                                colorId = 0,
                                colorHash = "") {
        searchSelectionButton.primaryText = text
        searchSelectionButton.secondaryText = secondaryText
        searchSelectionButton.image.source = imageSource
        searchSelectionButton.image.isIdenticon = isIdenticon
        searchSelectionButton.iconSettings.name = iconName
        searchSelectionButton.iconSettings.color = isUserIcon ? Theme.palette.userCustomizationColors[colorId] : iconColor
        searchSelectionButton.iconSettings.isLetterIdenticon = !iconName && !imageSource
        searchSelectionButton.iconSettings.charactersLen = isUserIcon ? 2 : 1
        searchSelectionButton.ringSettings.ringSpecModel = !!colorHash ? JSON.parse(colorHash) : {}
    }

    function resetSearchSelection() {
        setSearchSelection(defaultSearchLocationText, "", "", false, "", "transparent")
    }

    function forceActiveFocus() {
        contentItem.searchInput.edit.forceActiveFocus()
    }

    onOpened: {
        forceActiveFocus();
    }

    contentItem: Item {
        width: parent.width
        height: root.height
        property alias searchText: inputText.text
        property alias searchInput: inputText

        ColumnLayout {
            id: contentItemColumn
            anchors.fill: parent
            spacing: 0
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 63
                StatusIcon {
                    id: statusIcon
                    width: Theme.dp(40)
                    height: Theme.dp(40)
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.dp(12)
                    anchors.verticalCenter: parent.verticalCenter
                    icon: "search"
                    color: Theme.palette.baseColor1
                }

                StatusBaseInput {
                    id: inputText
                    anchors.left: statusIcon.right
                    anchors.leftMargin: Theme.dp(15)
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.dp(8)
                    anchors.verticalCenter: parent.verticalCenter
                    focus: true
                    font.pixelSize: Theme.dp(28)
                    topPadding: Theme.dp(5) //smaller padding to handle bigger font
                    bottomPadding: Theme.dp(5)
                    clearable: true
                    showBackground: false
                    font.family: Theme.palette.baseFont.name
                    color: Theme.palette.directColor1
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                            event.accepted = true
                    }
                }
            }
            StatusMenuSeparator {
                topPadding: 0
                Layout.fillWidth: true
            }
            Item {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: Theme.dp(58)
                Button {
                    id: searchOptionsMenuButton

                    Component.onCompleted: {
                        root.searchSelectionButton = searchOptionsMenuButton
                    }

                    property string prefixText: qsTr("In")
                    property string primaryText: ""
                    property string secondaryText: ""
                    property StatusIconSettings iconSettings: StatusIconSettings {
                        width: Theme.dp(16)
                        height: Theme.dp(16)
                        name: ""
                        isLetterIdenticon: false
                        letterSize: Theme.dp(charactersLen > 1 ? 8 : 11)
                    }

                    property StatusImageSettings image: StatusImageSettings {
                        width: Theme.dp(16)
                        height: Theme.dp(16)
                        source: ""
                        isIdenticon: false
                    }

                    property alias ringSettings: identicon.ringSettings

                    anchors.left: parent.left
                    anchors.leftMargin: Theme.dp(16)
                    anchors.verticalCenter: parent.verticalCenter

                    implicitWidth: (contentItemRowLayout.width + 24)
                    implicitHeight: Theme.dp(32)

                    background: Rectangle {
                        anchors.fill: parent
                        color: Theme.palette.baseColor2
                        radius: Theme.dp(8)
                    }

                    contentItem: Item {
                        anchors.fill: parent

                        MouseArea {
                            id: sensor
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.searchOptionsPopupMenu.popup();

                            RowLayout {
                                id: contentItemRowLayout
                                anchors.centerIn: parent
                                spacing: Theme.dp(2)
                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    text: searchOptionsMenuButton.prefixText + ": "
                                    font.weight: Font.Medium
                                }

                                StatusSmartIdenticon {
                                    id: identicon
                                    Layout.preferredWidth: active ? Theme.dp(16) : 0
                                    Layout.preferredHeight: Theme.dp(16)
                                    image: searchOptionsMenuButton.image
                                    icon: searchOptionsMenuButton.iconSettings
                                    name: searchOptionsMenuButton.primaryText
                                    active: searchOptionsMenuButton.primaryText !== defaultSearchLocationText &&
                                            (searchOptionsMenuButton.iconSettings.name ||
                                             searchOptionsMenuButton.iconSettings.isLetterIdenticon ||
                                             !!searchOptionsMenuButton.image.source.toString())
                                }

                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    text: searchOptionsMenuButton.primaryText
                                    font.weight: Font.Medium
                                }
                                StatusIcon {
                                    Layout.preferredWidth: Theme.dp(14)
                                    Layout.preferredHeight: Theme.dp(18)
                                    Layout.alignment: Qt.AlignVCenter
                                    visible: !!searchOptionsMenuButton.secondaryText
                                    color: Theme.palette.baseColor1
                                    icon: "next"
                                }
                                StatusIcon {
                                    Layout.preferredWidth: Theme.dp(18)
                                    Layout.preferredHeight: Theme.dp(18)
                                    Layout.alignment: Qt.AlignVCenter
                                    visible: !!searchOptionsMenuButton.secondaryText
                                    color: Theme.palette.directColor1
                                    icon: "channel"
                                }
                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    visible: !!searchOptionsMenuButton.secondaryText
                                    text: searchOptionsMenuButton.secondaryText
                                    font.weight: Font.Medium
                                }
                                StatusIcon {
                                    Layout.preferredWidth: Theme.dp(18)
                                    Layout.preferredHeight: Theme.dp(14)
                                    Layout.alignment: Qt.AlignVCenter
                                    icon: "chevron-down"
                                    color: Theme.palette.directColor1
                                }
                            }
                        }
                    }
                }

                StatusFlatRoundButton {
                    id: closeButton
                    width: Theme.dp(32)
                    height: Theme.dp(32)
                    anchors.left: searchOptionsMenuButton.right
                    anchors.leftMargin: Theme.dp(4)
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: (searchOptionsMenuButton.primaryText === defaultSearchLocationText) ? 0.0 : 1.0
                    visible: (opacity > 0.1)
                    type: StatusFlatRoundButton.Type.Secondary
                    icon.name: "close"
                    icon.color: Theme.palette.directColor1
                    icon.width: Theme.dp(20)
                    icon.height: Theme.dp(20)
                    onClicked: { root.resetSearchSelection(); }
                }
            }

            StatusMenuSeparator { Layout.fillWidth: true; visible: (root.height > 142) }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                ListView {
                    id: view
                    anchors.fill: parent
                    anchors {
                        leftMargin: 0
                        rightMargin: 0
                        bottomMargin: Theme.dp(67)
                    }
                    visible: (!root.loading && (count > 0))
                    model: root.searchResults
                    ScrollBar.vertical: ScrollBar { }
                    delegate: StatusListItem {
                        width: view.width
                        itemId: model.itemId
                        titleId: model.titleId
                        title: model.title
                        statusListItemTitle.color: model.title.startsWith("@") ? Theme.palette.primaryColor1 : Theme.palette.directColor1
                        subTitle: model.content
                        radius: 0
                        statusListItemSubTitle.height: model.content !== "" ? 20 : 0
                        statusListItemSubTitle.elide: Text.ElideRight
                        statusListItemSubTitle.color: Theme.palette.directColor1
                        icon.isLetterIdenticon: (model.image === "")
                        icon.color: model.isUserIcon ? Theme.palette.userCustomizationColors[model.colorId] : model.color
                        icon.charactersLen: model.isUserIcon ? 2 : 1
                        titleAsideText: root.formatTimestampFn(model.time)
                        image.source: model.image
                        badge.primaryText: model.badgePrimaryText
                        badge.secondaryText: model.badgeSecondaryText
                        badge.image.source: model.badgeImage
                        badge.icon.isLetterIdenticon: model.badgeIsLetterIdenticon
                        badge.icon.color: model.badgeIconColor
                        ringSettings.ringSpecModel: model.colorHash

                        onClicked: {
                            root.resultItemClicked(itemId)
                        }

                        propagateTitleClicks: !root.acceptsTitleClick(titleId)
                        onTitleClicked: {
                            if (root.acceptsTitleClick(titleId)) {
                                root.resultItemTitleClicked(titleId)
                            }
                        }
                    }
                    section.property: "sectionName"
                    section.criteria: ViewSection.FullString
                    section.delegate: Item {
                        height: Theme.dp(34)
                        width: view.width
                        StatusBaseText {
                            font.pixelSize: Theme.dp(15)
                            color: Theme.palette.baseColor1
                            text: section
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.dp(16)
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: Theme.dp(4)
                        }
                    }
                }
                StatusLoadingIndicator {
                    anchors.centerIn: parent
                    visible: root.loading
                    color: Theme.palette.primaryColor1
                    width: Theme.dp(24)
                    height: Theme.dp(24)
                }

                StatusBaseText {
                    anchors.centerIn: parent
                    text: root.noResultsLabel
                    color: Theme.palette.baseColor1
                    font.pixelSize: Theme.dp(13)
                    visible: ((inputText.text !== "") && (view.count === 0) && !root.loading)
                }
            }
        }
    }
    onClosed: {
        root.resetSearchSelection();
        root.loading = false;
        contentItem.searchText = "";
    }
}
