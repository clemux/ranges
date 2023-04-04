import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    property alias actionList: actionList

    ColumnLayout {
        ButtonGroup {
            id: buttonGroup
        }
        ListView {
            id: actionList
            height: actionListModel.count * 40

            delegate: RadioDelegate {
                id: actionDelegate

                property string currentAction: model.value

                ButtonGroup.group: buttonGroup
                checked: index === 0
                text: model.label

                onClicked: {
                    actionList.currentIndex = index;
                }
            }
            model: ListModel {
                id: actionListModel
                ListElement {
                    label: "RFI"
                    value: "rfi"
                }
                ListElement {
                    label: "Call"
                    value: "call"
                }
                ListElement {
                    label: "3Bet"
                    value: "3bet"
                }
            }
        }
    }
}
