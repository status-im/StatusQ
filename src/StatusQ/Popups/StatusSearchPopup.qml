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
    width: 700
    height: (!!searchResults && (searchResults.count >= 0) && (searchText !== "")) ? (((searchResults.count < 5)) ? 560 : 770) : 142 //970
    anchors.centerIn: parent
    showHeader: false
    showFooter: false

    property string searchText: contentComponent.searchText
    property string selectionBadgeIcon: ""
    property string selectionBadgeImage: ""
    property string selectionBadgePrimaryText: ""
    property string selectionBadgeSecondaryText: ""
    property string selectionBadgeIdenticonColor: ""
    property bool loading
    property Component searchOptionsPopupMenu
    property ListModel searchResults: ListModel { }
    function resetSelectionBadge() {
        selectionBadgeIcon = "";
        selectionBadgeImage = "";
        selectionBadgePrimaryText = qsTr("Anywhere");
        selectionBadgeSecondaryText = "";
        selectionBadgeIdenticonColor = "";
    }

    content: Item {
        width: parent.width
        height: root.height
        property alias searchText: inputText.text

        ColumnLayout {
            id: contentItemColumn
            anchors.fill: parent
            spacing: 0
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 63
                StatusIcon {
                    id: statusIcon
                    width: 28
                    height: 28
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    icon: "search"
                    color: Theme.palette.baseColor1
                }
                TextEdit {
                    id: inputText
                    anchors.left: statusIcon.right
                    anchors.leftMargin: 15
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    focus: true
                    font.pixelSize: 28
                    font.family: Theme.palette.baseFont.name
                    color: Theme.palette.directColor1
                }
            }
            StatusMenuSeparator { Layout.fillWidth: true }
            Item {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 58
                Button {
                    id: searchOptionsMenuButton
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    implicitWidth: (contentItemRowLayout.width + 24)
                    implicitHeight: 32
                    background: Rectangle {
                        anchors.fill: parent
                        color: Theme.palette.baseColor2
                        radius: 8
                    }

                    contentItem: Item {
                        anchors.fill: parent
                        RowLayout {
                            id: contentItemRowLayout
                            anchors.centerIn: parent
                            spacing: 2
                            StatusBaseText {
                                color: Theme.palette.directColor1
                                text: "In: "
                            }
                            StatusIcon {
                                Layout.preferredWidth: 16
                                Layout.preferredHeight: 16
                                visible: !!root.selectionBadgeIcon
                                icon: root.selectionBadgeIcon
                            }
                            StatusRoundedImage {
                                implicitWidth: 16
                                implicitHeight: 16
                                visible: !!root.selectionBadgeImage
                                image.source: root.selectionBadgeImage
                            }
                            StatusLetterIdenticon {
                                implicitWidth: 16
                                implicitHeight: 16
                                letterSize: 11
                                visible: ((root.selectionBadgeImage === "") && (root.selectionBadgePrimaryText !== qsTr("Anywhere")))
                                color: root.selectionBadgeIdenticonColor
                                name: root.selectionBadgePrimaryText
                            }
                            StatusBaseText {
                                color: Theme.palette.directColor1
                                text: root.selectionBadgePrimaryText
                            }
                            StatusIcon {
                                Layout.preferredWidth: 14.5
                                Layout.preferredHeight: 17.5
                                Layout.alignment: Qt.AlignVCenter
                                visible: !!root.selectionBadgeSecondaryText
                                color: Theme.palette.baseColor1
                                icon: "next"
                            }
                            StatusBaseText {
                                color: Theme.palette.directColor1
                                visible: !!root.selectionBadgeSecondaryText
                                text: "#" + root.selectionBadgeSecondaryText
                            }
                            StatusIcon {
                                Layout.preferredWidth: 17.5
                                Layout.preferredHeight: 14.5
                                Layout.alignment: Qt.AlignVCenter
                                icon: "chevron-down"
                            }
                        }
                    }
                    onClicked: { searchPopupMenuLoader.item.popup(); }
                }

                Loader {
                    id: searchPopupMenuLoader
                    sourceComponent: root.searchOptionsPopupMenu
                }

                StatusFlatRoundButton {
                    id: closeButton
                    width: 32
                    height: 32
                    anchors.left: searchOptionsMenuButton.right
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: (root.selectionBadgePrimaryText === qsTr("Anywhere")) ? 0.0 : 1.0
                    visible: (opacity > 0.1)
                    type: StatusFlatRoundButton.Type.Secondary
                    icon.name: "close"
                    icon.color: Theme.palette.directColor1
                    icon.width: 20
                    icon.height: 20
                    onClicked: { root.resetSelectionBadge(); }
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
                        leftMargin: 8
                        rightMargin: 19
                        bottomMargin: 67
                    }
                    visible: (!root.loading && (count > 0))
                    model: root.searchResults
                    ScrollBar.vertical: ScrollBar { }
                    delegate: StatusListItem {
                        width: view.width
                        title: model.name
                        statusListItemTitle.color: model.name.startsWith("@") ? Theme.palette.primaryColor1 : Theme.palette.directColor1
                        subTitle: model.content
                        statusListItemSubTitle.height: model.content !== "" ? 20 : 0
                        statusListItemSubTitle.elide: Text.ElideRight
                        statusListItemSubTitle.color: Theme.palette.black
                        icon.isLetterIdenticon: (model.badgeImage === "")
                        titleAsideText: model.time
                        image.source: model.badgeImage
                        badge.primaryText: model.badgePrimaryText
                        badge.secondaryText: model.badgeSecondaryText
                        badge.image.source: model.badgeImage
                        badge.icon.isLetterIdenticon: model.isLetterIdenticon
                        badge.icon.color: model.badgeIdenticonColor
                    }
                    section.property: "type"
                    section.criteria: ViewSection.FullString
                    section.delegate: StatusBaseText {
                        font.pixelSize: 15
                        color: Theme.palette.baseColor1
                        text: section
                    }
                }
                StatusLoadingIndicator {
                    anchors.centerIn: parent
                    visible: root.loading
                }

                StatusBaseText {
                    anchors.centerIn: parent
                    text: qsTr("No results")
                    color: Theme.palette.baseColor1
                    font.pixelSize: 13
                    visible: ((inputText.text !== "") && (view.count === 0) && !root.loading)
                }
            }
        }
    }
    onClosed: {
        root.resetSelectionBadge();
        root.loading = false;
        contentComponent.searchText = "";
        root.searchResults.clear();
    }
}
