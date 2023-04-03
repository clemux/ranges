import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "main.js" as Functions

ApplicationWindow {
    property list<string> positions: ["LJ", "HJ", "CO", "BTN", "SB", "BB"]

    Material.theme: Material.Light
    height: 768
    title: "Ranges"
    visible: true
    width: 1024

    GridLayout {
        property alias actionList: actionList

        Layout.alignment: Qt.AlignTop
        Layout.row: 1
        anchors.fill: parent
        anchors.margins: 0
        columns: 2
        rows: 4
        columnSpacing: 0
        flow: GridLayout.TopToBottom

        TabBar {
            id: bar
            Layout.fillWidth: true
            Layout.row: 0
            Layout.alignment: Qt.AlignTop

            Repeater {
                model: positions

                TabButton {
                    text: modelData
                }
            }
        }
        StackLayout {
            id: stack
            Layout.alignment: Qt.AlignLeft
            Layout.row: 1
            Layout.rowSpan: 3
            Layout.column: 0
            Layout.fillWidth: true
            currentIndex: bar.currentIndex

            Repeater {
                id: rangeRepeater
                model: positions

                Range {
                    position: modelData
                }
            }
        }
        TextField {
            id: rangeText
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft
            text: rangeRepeater.itemAt(stack.currentIndex).toText()

            onAccepted: {
                let range = rangeRepeater.itemAt(stack.currentIndex);
                range.clearCombos();
                range.setActionCombos(rangeText.text, actionBox.value);
            }
        }
        Text {
            Layout.column: 1
            Layout.row: 2
            id: nbCardsText
            function getText() {
                const range = rangeRepeater.itemAt(stack.currentIndex);
                const nbCards = range.nbCards();
                const percent = (nbCards * 100 / 1326).toFixed(2);
                return `${nbCards} cards (${percent}%)`;
            }

            text: getText()
        }
        ButtonGroup {
            id: buttonGroup
        }
        ListView {
            Layout.row: 3
            Layout.column: 1
            id: actionList
            height: 3 * 60

            delegate: RadioDelegate {
                id: actionDelegate

                property string currentAction: model.value

                ButtonGroup.group: buttonGroup
                checked: index == 0
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