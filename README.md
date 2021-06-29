# StatusQ

> An emerging reusable QML UI component library for Status applications.

## Usage

StatusQ introduces a module namespace that semantically groups components so they can be easily imported.
These modules are:

- [StatusQ.Core](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/qmldir)
- [StatusQ.Core.Theme](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/qmldir)
- [StatusQ.Components](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/qmldir)
- [StatusQ.Controls](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/qmldir)
- [StatusQ.Layout](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Layout/qmldir)
- [StatusQ.Platform](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Platform/qmldir)
- [StatusQ.Popups](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/qmldir)

Provided components can be viewed and tested in the [sandbox application](#viewing-and-testing-components) that comes with this repository.
Other than that, modules and components can be used as expected.

Example:

```
import Status.Core 0.1
import Status.Controls 0.1

StatusInput {
  ...
}
```

## Viewing and testing components

To make viewing and testing components easy, we've added a sandbox application to this repository in which StatusQ components are being build. This is the first place where components see the light of the world and can be run in a proper application environment.

<img width="1136" alt="Screenshot 2021-06-29 at 10 13 02" src="https://user-images.githubusercontent.com/445106/123764172-d4c80500-d8c4-11eb-9707-5cb2dc321c1f.png">


### Using Qt Creator

The easiest way to run the sandbox application is to simply open the provided `sandbox.pro` file using Qt Creator.

### Using command line interface

To run the sandbox from within a command line interface, run the following commands:

```
$ git clone https://github.com/status-im/StatusQ
$ cd StatusQ/sandbox
$ ./scripts/build
```

Once that is done, the sandbox can be started with the generated executable:

```
$ ./bin/sandbox
```

## Implementation status

|  | Issue | Status
:--- | :------: | :-----------: 
**StatusQ.Core** |  |
[`StatusBaseText`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusBaseText.qml) | [#20](https://github.com/status-im/StatusQ/issues/20) | ✅
[`StatusIcon`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusIcon.qml) | [#2](https://github.com/status-im/StatusQ/issues/2) | ✅
[`StatusIconBackgroundSettings`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusIconBackgroundSettings.qml) | - | ✅
[`StatusIconSettings`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusIconSettings.qml) | - | ✅
[`StatusImageSettings`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusImageSettings.qml) | - | ✅
[`StatusModalHeaderSettings`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/StatusModalHeaderSettings.qml) | - | ✅
**StatusQ.Core.Theme** | 
[`StatusColors`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/StatusColors.qml) | [#3](https://github.com/status-im/StatusQ/issues/3) | ✅
[`StatusDarkTheme`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/StatusDarkTheme.qml) | [#3](https://github.com/status-im/StatusQ/issues/3) | ✅
[`StatusLightTheme`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/StatusLightTheme.qml) | [#3](https://github.com/status-im/StatusQ/issues/3) | ✅
[`Theme`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/Theme.qml) | [#3](https://github.com/status-im/StatusQ/issues/3) | ✅
[`ThemePalette`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Core/Theme/ThemePalette.qml) | [#3](https://github.com/status-im/StatusQ/issues/3) | ✅
**StatusQ.Components** | 
[`StatusBadge`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusBadge.qml) | [#15](https://github.com/status-im/StatusQ/issues/15) | ✅
[`StatusChatInfoToolBar`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatInfoToolBar.qml) | [#141](https://github.com/status-im/StatusQ/issues/141) | ✅
[`StatusChatList`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatList.qml) | [#100](https://github.com/status-im/StatusQ/issues/100) | ✅
[`StatusChatListAndCategories`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatListAndCategories.qml) | [#133](https://github.com/status-im/StatusQ/issues/133) | ✅
[`StatusChatListCategory`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatListCategory.qml) | [#123](https://github.com/status-im/StatusQ/issues/123) | ✅
[`StatusChatListCategoryItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatListCategoryItem.qml) | [#123](https://github.com/status-im/StatusQ/issues/123) | ✅
[`StatusChatListItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatListItem.qml) | [#65](https://github.com/status-im/StatusQ/issues/65) | ✅
[`StatusChatToolBar`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusChatToolBar.qml) | [#80](https://github.com/status-im/StatusQ/issues/80) | ✅
[`StatusContactRequestsIndicatorListItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusContactRequestsIndicatorListItem.qml) | [#175](https://github.com/status-im/StatusQ/issues/175) | ✅
[`StatusDescriptionListItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusDescriptionListItem.qml) | [#73](https://github.com/status-im/StatusQ/issues/73) | ✅
[`StatusLetterIdenticon`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusLetterIdenticon.qml) | [#28](https://github.com/status-im/StatusQ/issues/28) | ✅
[`StatusListItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusListItem.qml) | [#19](https://github.com/status-im/StatusQ/issues/19) | ✅
[`StatusListSectionHeadline`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusListSectionHeadline.qml) | [#164](https://github.com/status-im/StatusQ/issues/164) | ✅
[`StatusLoadingIndicator`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusLoadingIndicator.qml) | [#7](https://github.com/status-im/StatusQ/issues/7) | ✅
[`StatusNavigationListItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusNavigationListItem.qml) | [#72](https://github.com/status-im/StatusQ/issues/72) | ✅
[`StatusNavigationPanelHeadline`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusNavigationPanelHeadline.qml) | [#162](https://github.com/status-im/StatusQ/issues/162) | ✅
`StatusNotification` | [#104](https://github.com/status-im/StatusQ/issues/104) | 🚫
[`StatusRoundIcon`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusRoundIcon.qml) | [#53](https://github.com/status-im/StatusQ/issues/53) | ✅
[`StatusRoundedImage`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Components/StatusRoundedImage.qml) | [#32](https://github.com/status-im/StatusQ/issues/32) | ✅
`StatusThemeSelector` | [#105](https://github.com/status-im/StatusQ/issues/105) | 🚫
**StatusQ.Controls** |
[`StatusBaseButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusBaseButton.qml) | [#6](https://github.com/status-im/StatusQ/issues/6) | ✅
`StatusBaseInput` | [#106](https://github.com/status-im/StatusQ/issues/106) | 🚧
[`StatusButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusButton.qml) | [#6](https://github.com/status-im/StatusQ/issues/6) | ✅
[`StatusChatInfoButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusChatInfoButton.qml) | [#79](https://github.com/status-im/StatusQ/issues/79) | ✅
[`StatusChatListCategoryItemButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusChatListCategoryItemButton.qml) | [#117](https://github.com/status-im/StatusQ/issues/117) | ✅
[`StatusCheckBox`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusCheckBox.qml) | [#10](https://github.com/status-im/StatusQ/issues/10) | ✅
[`StatusFlatButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusFlatButton.qml) | [#6](https://github.com/status-im/StatusQ/issues/6) | ✅
[`StatusFlatRoundButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusFlatRoundButton.qml) | [#6](https://github.com/status-im/StatusQ/issues/6) | ✅
[`StatusIconTabButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusIconTabButton.qml) | [#16](https://github.com/status-im/StatusQ/issues/16) | ✅
[`StatusNavBarTabButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusNavBarTabButton.qml) | [#17](https://github.com/status-im/StatusQ/issues/17) | ✅
[`StatusRadioButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusRadioButton.qml) | [#11](https://github.com/status-im/StatusQ/issues/11) | ✅
[`StatusRoundButton`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusRoundButton.qml) | [#6](https://github.com/status-im/StatusQ/issues/6) | ✅
[`StatusSlider`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusSlider.qml) | [#13](https://github.com/status-im/StatusQ/issues/13) | ✅
[`StatusSwitch`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusSwitch.qml) | [#12](https://github.com/status-im/StatusQ/issues/12) | ✅
[`StatusToolTip`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Controls/StatusToolTip.qml) | [#14](https://github.com/status-im/StatusQ/issues/14) | ✅
`StatusWalletColorButton` | [#101](https://github.com/status-im/StatusQ/issues/101) | 🚫
`StatusWalletColorSelect` | [#102](https://github.com/status-im/StatusQ/issues/102) | 🚫
**StatusQ.Layout** |
[`StatusAppLayout`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Layout/StatusAppLayout.qml) | [#77](https://github.com/status-im/StatusQ/issues/77) | ✅
[`StatusAppNavBar`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Layout/StatusAppNavBar.qml) | [#18](https://github.com/status-im/StatusQ/issues/18) | ✅
[`StatusAppTwoPanelLayout`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Layout/StatusAppTwoPanelLayout.qml) | [#78](https://github.com/status-im/StatusQ/issues/78) | ✅
**StatusQ.Platform** |
[`StatusMacTrafficLights`](https://github.com/status-im/StatusQ/tree/master/src/StatusQ/Platform) | [#108](https://github.com/status-im/StatusQ/pull/108) | ✅
`StatusWindowsToolBar` | [#200](https://github.com/status-im/StatusQ/issues/200) | 🚫
**StatusQ.Popups** |
[`StatusMenuItem`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/StatusMenuItem.qml) | [#74](https://github.com/status-im/StatusQ/issues/74) | ✅
[`StatusMenuSeparator`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/StatusMenuSeparator.qml) | - | ✅
[`StatusModal`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/StatusModal.qml) | [#97](https://github.com/status-im/StatusQ/issues/97) | ✅
[`StatusModalDivider`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/StatusModalDivider.qml) | [#97](https://github.com/status-im/StatusQ/issues/97) | ✅
[`StatusPopupMenu`](https://github.com/status-im/StatusQ/blob/master/src/StatusQ/Popups/StatusPopupMenu.qml) | [#96](https://github.com/status-im/StatusQ/issues/96) | ✅
`StatusTextFormatMenu` | [#103](https://github.com/status-im/StatusQ/issues/103) | 🚫
