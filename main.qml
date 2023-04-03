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

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: bar
            Layout.fillWidth: true

            Repeater {
                model: positions

                TabButton {
                    text: modelData
                }
            }
        }
        RowLayout {
            property alias actionList: actionList

            Layout.alignment: Qt.AlignTop

            StackLayout {
                id: stack
                Layout.alignment: Qt.AlignLeft
                currentIndex: bar.currentIndex

                Repeater {
                    id: rangeRepeater
                    model: positions

                    Range {
                        position: modelData
                    }
                }
            }
            ColumnLayout {
                spacing: 20

                TextField {
                    id: rangeText
                    text: rangeRepeater.itemAt(stack.currentIndex).toText()

                    onAccepted: {
                        console.log(actionBox.value);
                        let range = rangeRepeater.itemAt(stack.currentIndex);
                        range.clearCombos();
                        range.setActionCombos(rangeText.text, actionBox.value);
                    }
                }
                Text {
                    id: nbCardsText
                    function getText() {
                        const range = rangeRepeater.itemAt(stack.currentIndex);
                        const nbCards = range.nbCards();
                        const percent = (nbCards * 100 / 1326).toFixed(2);
                        return `${nbCards} (${percent}%)`;
                    }

                    text: getText()
                }
                ButtonGroup {
                    id: buttonGroup
                }
                ListView {
                    id: actionList
                    height: 3 * 60
                    model: ListModel {
                        id: actionListModel
                        ListElement { value: "rfi"; label: "RFI"}
                        ListElement { value: "call"; label: "Call"}
                        ListElement { value: "3bet"; label: "3Bet"}
                    }

                    delegate: RadioDelegate {
                        property string currentAction: model.value
                        id: actionDelegate
                        ButtonGroup.group: buttonGroup
                        checked: index == 0
                        text: model.label
                        onClicked: {
                            actionList.currentIndex = index
                        }
                    }
                }
            }
        }
    }
}