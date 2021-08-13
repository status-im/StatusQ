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
    property string noResultsLabel: "No results"
    property bool loading
    property Menu searchOptionsPopupMenu: Menu { }
    property var searchResults: [ ]
    property var searchSelectionButton
    function resetSelectionBadge() {
        searchSelectionButton.iconSettings.name = ""
        searchSelectionButton.iconSettings.isLetterIdenticon = false
        searchSelectionButton.iconSettings.color = "transparent"
        searchSelectionButton.image.source = ""
        searchSelectionButton.image.isIdenticon = false
        searchSelectionButton.primaryText = qsTr("Anywhere");
        searchSelectionButton.secondaryText = "";
    }

    onSearchResultsChanged: {
        var curIndexes = [...Array(searchResults.count)].map((v,i) => i);
        curIndexes.sort((a,b) => searchResults.get(a).sectionName.localeCompare(searchResults.get(b).sectionName));
        var sorted = 0;
        while ((sorted < curIndexes.length) && (sorted === curIndexes[sorted])) {
            sorted++;
        }
        if (sorted === curIndexes.length) {
            return;
        }
        for (let i = sorted; i < curIndexes.length; i++) {
            searchResults.move(curIndexes[i], searchResults.count - 1, 1);
            searchResults.insert(curIndexes[i], { } );
        }
        searchResults.remove(sorted, curIndexes.length - sorted);
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
                    width: 40
                    height: 40
                    anchors.left: parent.left
                    anchors.leftMargin: 12
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
            StatusMenuSeparator { 
                topPadding: 0
                Layout.fillWidth: true 
            }
            Item {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 58
                Button {
                    id: searchOptionsMenuButton

                    Component.onCompleted: {
                        root.searchSelectionButton = searchOptionsMenuButton
                    }

                    property string prefixText: "In"
                    property string primaryText: ""
                    property string secondaryText: ""
                    property StatusIconSettings iconSettings: StatusIconSettings {
                        name: ""
                        isLetterIdenticon: false
                    }

                    property StatusImageSettings image: StatusImageSettings {
                        source: ""
                        isIdenticon: false
                    }

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

                        MouseArea {
                            id: sensor
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor 
                            onClicked: root.searchOptionsPopupMenu.popup();

                            RowLayout {
                                id: contentItemRowLayout
                                anchors.centerIn: parent
                                spacing: 2
                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    text: searchOptionsMenuButton.prefixText + ": "
                                    font.weight: Font.Medium
                                }

                                Loader {
                                    Layout.preferredWidth: active ? 16 : 0
                                    Layout.preferredHeight: 16
                                    active: searchOptionsMenuButton.iconSettings.name ||
                                        searchOptionsMenuButton.iconSettings.isLetterIdenticon ||
                                        !!searchOptionsMenuButton.image.source.toString()

                                    sourceComponent: {
                                        if (!!searchOptionsMenuButton.image.source.toString()) {
                                            return statusRoundedImageCmp
                                        }
                                        if (!!searchOptionsMenuButton.iconSettings.isLetterIdenticon || !searchOptionsMenuButton.iconSettings.name) {
                                            return statusLetterIdenticonCmp
                                        }
                                        return statusIconCmp
                                    }
                                }

                                Component {
                                    id: statusIconCmp
                                    StatusIcon {
                                        width: 16
                                        icon: searchOptionsMenuButton.iconSettings.name
                                        color: searchOptionsMenuButton.iconSettings.color
                                    }
                                }

                                Component {
                                    id: statusRoundedImageCmp
                                    Item {
                                        width: 16
                                        height: 16
                                        StatusRoundedImage {
                                            id: statusRoundedImage
                                            implicitWidth: parent.width
                                            implicitHeight: parent.height
                                            image.source: searchOptionsMenuButton.image.source
                                            color: searchOptionsMenuButton.image.isIdenticon ?
                                                Theme.palette.statusRoundedImage.backgroundColor :
                                                "transparent"
                                            border.width: searchOptionsMenuButton.image.isIdenticon ? 1 : 0
                                            border.color: Theme.palette.directColor7
                                        }

                                        Loader {
                                            sourceComponent: statusLetterIdenticonCmp
                                            active: statusRoundedImage.image.status === Image.Error
                                        }
                                    }
                                }

                                Component {
                                    id: statusLetterIdenticonCmp
                                    StatusLetterIdenticon {
                                        implicitWidth: 16
                                        implicitHeight: 16
                                        letterSize: 11
                                        color: searchOptionsMenuButton.iconSettings.color
                                        name: searchOptionsMenuButton.primaryText
                                    }
                                }

                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    text: searchOptionsMenuButton.primaryText
                                    font.weight: Font.Medium
                                }
                                StatusIcon {
                                    Layout.preferredWidth: 14.5
                                    Layout.preferredHeight: 17.5
                                    Layout.alignment: Qt.AlignVCenter
                                    visible: !!searchOptionsMenuButton.secondaryText
                                    color: Theme.palette.baseColor1
                                    icon: "next"
                                }
                                StatusBaseText {
                                    color: Theme.palette.directColor1
                                    visible: !!searchOptionsMenuButton.secondaryText
                                    text: "# " + searchOptionsMenuButton.secondaryText
                                    font.weight: Font.Medium
                                }
                                StatusIcon {
                                    Layout.preferredWidth: 17.5
                                    Layout.preferredHeight: 14.5
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
                    width: 32
                    height: 32
                    anchors.left: searchOptionsMenuButton.right
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: (searchOptionsMenuButton.primaryText === qsTr("Anywhere")) ? 0.0 : 1.0
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
                        leftMargin: 0
                        rightMargin: 0
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
                        radius: 0
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
                    section.property: "sectionName"
                    section.criteria: ViewSection.FullString
                    section.delegate: Item {
                        height: 34
                        width: view.width
                        StatusBaseText {
                            font.pixelSize: 15
                            color: Theme.palette.baseColor1
                            text: section
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 4
                        }
                    }
                }
                StatusLoadingIndicator {
                    anchors.centerIn: parent
                    visible: root.loading
                    color: Theme.palette.primaryColor1
                    width: 24
                    height: 24
                }

                StatusBaseText {
                    anchors.centerIn: parent
                    text: root.noResultsLabel
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
    }
}
