import QtQuick 2.13
import QtQuick.Controls 2.13
import StatusQ.Controls 0.1
import StatusQ.Core.Theme 0.1

Item {
  id: root
  property string selectedColor
  property string label: "Color"
  property var model
  height: accountColorInput.height
  implicitWidth: Theme.dp(448)

  StatusSelect {
      id: accountColorInput
      bgColor: selectedColor
      label: root.label
      model: root.model

      selectMenu.delegate: Component {
          MenuItem {
              property bool isFirstItem: index === 0
              property bool isLastItem: index === root.model.length - 1
              height: Theme.dp(52)
              width: parent.width
              padding: Theme.dp(10)
              onTriggered: function () {
                  const selectedColor = root.model[index]
                  root.selectedColor = selectedColor
              }
              background: Rectangle {
                  color: root.model[index] || "transparent"
              }
          }
      }
  }
}

