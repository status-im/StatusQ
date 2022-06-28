import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQml.Models 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1
import StatusQ.Controls 0.1

Item {
    id: root
    property string label: "Choose account"
    property bool showAccountDetails: !!selectedAccount
    property var accounts
    property var selectedAccount
    property string currency: "usd"
    property alias selectField: select
    implicitWidth: Theme.dp(448)
    height: select.height +
            (selectedAccountDetails.visible ? selectedAccountDetails.height + selectedAccountDetails.anchors.topMargin : 0)
    // set to asset symbol to display asset's balance top right
    // NOTE: if this asset is not selected as a wallet token in the UI, then
    // nothing will be displayed
    property string showBalanceForAssetSymbol: ""
    property var assetFound
    property double minRequiredAssetBalance: 0
    property int dropdownWidth: width
    property int chainId: 0
    property alias dropdownAlignment: select.menuAlignment
    property bool isValid: true
    property bool readOnly: false

    property var assetBalanceTextFn: function (foundValue) {
        return "Balance: " + (parseFloat(foundValue) === 0.0 ? "0" : Utils.stripTrailingZeros(foundValue))
    }

    readonly property string watchWalletType: "watch"

    enum Type {
        Address,
        Contact,
        Account
    }

    function validate() {
        if (showBalanceForAssetSymbol == "" || minRequiredAssetBalance == 0 || !assetFound) {
            return root.isValid
        }
        root.isValid = assetFound.totalBalance >= minRequiredAssetBalance
        return root.isValid
    }

    onSelectedAccountChanged: {
        if (!selectedAccount) {
            return
        }
        if (selectedAccount.color) {
            selectedIconImg.color = Utils.getThemeAccountColor(selectedAccount.color, Theme.palette.userCustomizationColors) || Theme.palette.userCustomizationColors[0]
        }
        if (selectedAccount.name) {
            selectedTextField.text = selectedAccount.name
        }
        if (selectedAccount.address) {
            textSelectedAddress.text = selectedAccount.address  + " •"
        }
        if (selectedAccount.currencyBalance) {
            textSelectedAddressFiatBalance.text = selectedAccount.currencyBalance + " " + currency.toUpperCase()
        }
        if (selectedAccount.assets && showBalanceForAssetSymbol) {
            assetFound = Utils.findAssetByChainAndSymbol(root.chainId, selectedAccount.assets, showBalanceForAssetSymbol)
            if (!assetFound) {
                console.warn("Cannot find asset '", showBalanceForAssetSymbol, "'. Ensure this asset has been added to the token list.")
            }
        }
        if (!selectedAccount.type) {
            selectedAccount.type = StatusAccountSelector.Type.Account
        }
        validate()
    }

    onAssetFoundChanged: {
        if (!assetFound) {
            return
        }
        txtAssetBalance.text = root.assetBalanceTextFn(assetFound.totalBalance)
        txtAssetSymbol.text = " " + assetFound.symbol
    }

    StatusBaseText {
        id: txtAssetBalance
        visible: root.assetFound !== undefined
        anchors.bottom: select.top
        anchors.bottomMargin: -Theme.dp(18)
        anchors.right: txtAssetSymbol.left
        anchors.left: select.left
        anchors.leftMargin: select.width / 2.5

        color: !root.isValid ? Theme.palette.dangerColor1 : Theme.palette.baseColor1
        elide: Text.ElideRight
        font.pixelSize: Theme.dp(13)
        horizontalAlignment: Text.AlignRight
        height: Theme.dp(18)

        StatusToolTip {
            enabled: txtAssetBalance.truncated
            id: assetTooltip
            text: txtAssetBalance.text
        }

        MouseArea {
            enabled: txtAssetBalance.truncated
            anchors.fill: parent
            hoverEnabled: enabled
            onEntered: assetTooltip.visible = true
            onExited: assetTooltip.visible = false
        }
    }
    StatusBaseText {
        id: txtAssetSymbol
        visible: txtAssetBalance.visible
        anchors.top: txtAssetBalance.top
        anchors.right: parent.right

        color: txtAssetBalance.color
        font.pixelSize: Theme.dp(13)
        height: txtAssetBalance.height
    }
    StatusSelect {
        id: select
        label: root.label
        model: root.accounts
        width: parent.width
        menuAlignment: StatusSelect.MenuAlignment.Left
        selectMenu.delegate: menuItem
        selectMenu.width: dropdownWidth
        selectedItemComponent: Item {
            anchors.fill: parent

            StatusIcon {
                id: selectedIconImg
                anchors.left: parent.left
                anchors.leftMargin: Theme.dp(16)
                anchors.verticalCenter: parent.verticalCenter
                width: Theme.dp(20)
                height: Theme.dp(20)
                icon: "filled-account"
            }

            StatusBaseText {
                id: selectedTextField
                elide: Text.ElideRight
                anchors.left: selectedIconImg.right
                anchors.leftMargin: Theme.dp(8)
                anchors.right: parent.right
                anchors.rightMargin: select.selectedItemRightMargin
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Theme.dp(15)
                verticalAlignment: Text.AlignVCenter
                height: Theme.dp(22)
                color: Theme.palette.directColor1
            }
        }
    }

    Row {
        id: selectedAccountDetails
        visible: root.showAccountDetails
        anchors.top: select.bottom
        anchors.topMargin: Theme.dp(8)
        anchors.left: parent.left
        anchors.leftMargin: Theme.dp(2)

        StatusBaseText {
            id: textSelectedAddress
            font.pixelSize: Theme.dp(12)
            elide: Text.ElideMiddle
            width: Theme.dp(90)
            color: Theme.palette.baseColor1
        }
        StatusBaseText {
            id: textSelectedAddressFiatBalance
            font.pixelSize: Theme.dp(12)
            color: Theme.palette.baseColor1
        }
    }

    Component {
        id: menuItem
        MenuItem {
            id: itemContainer
            visible: walletType !== root.watchWalletType
            property bool isFirstItem: index === 0
            property bool isLastItem: index === accounts.rowCount() - 1

            Component.onCompleted: {
                if (!root.selectedAccount && isFirstItem) {
                    root.selectedAccount = { address, name, color: model.color, assets, currencyBalance }
                }
            }

            height: walletType === root.watchWalletType ? 0 : (accountName.height + Theme.dp(14) + accountAddress.height + Theme.dp(14))

            StatusIcon {
                id: iconImg
                anchors.left: parent.left
                anchors.leftMargin: Theme.dp(16)
                anchors.verticalCenter: parent.verticalCenter
                width: Theme.dp(20)
                height: Theme.dp(20)
                icon: "filled-account"
                color: Utils.getThemeAccountColor(model.color, Theme.palette.userCustomizationColors) || Theme.palette.userCustomizationColors[0]
            }

            Column {
                id: column
                anchors.left: iconImg.right
                anchors.leftMargin: Theme.dp(14)
                anchors.right: txtFiatBalance.left
                anchors.rightMargin: Theme.dp(8)
                anchors.verticalCenter: parent.verticalCenter

                StatusBaseText {
                    id: accountName
                    text: model.name
                    elide: Text.ElideRight
                    font.pixelSize: Theme.dp(15)
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Theme.dp(22)
                    color: Theme.palette.directColor1
                }

                StatusBaseText {
                    id: accountAddress
                    text: address
                    elide: Text.ElideMiddle
                    width: Theme.dp(80)
                    color: Theme.palette.baseColor1
                    font.pixelSize: Theme.dp(12)
                    height: Theme.dp(16)
                }
            }
            StatusBaseText {
                id: txtFiatBalance
                anchors.right: fiatCurrencySymbol.left
                anchors.rightMargin: Theme.dp(4)
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Theme.dp(15)
                height: Theme.dp(22)
                text: currencyBalance
                color: Theme.palette.directColor1
            }
            StatusBaseText {
                id: fiatCurrencySymbol
                anchors.right: parent.right
                anchors.rightMargin: Theme.dp(16)
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Theme.dp(15)
                height: Theme.dp(22)
                color: Theme.palette.baseColor1
                text: root.currency.toUpperCase()
            }
            background: Rectangle {
                color: itemContainer.highlighted ? Theme.palette.statusSelect.menuItemHoverBackgroundColor : Theme.palette.statusSelect.menuItemBackgroundColor
            }
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: itemContainer
                onClicked: {
                    root.selectedAccount = { address, name, color: model.color, assets, currencyBalance }
                    select.selectMenu.close()
                }
            }
        }
    }
}

