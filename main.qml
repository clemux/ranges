import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import "main.js" as Functions

ApplicationWindow {
    property list<string> positions: ["LJ", "HJ", "CO", "BTN", "SB", "BB"]
    property list<string> versuses: ["LJ", "HJ", "CO", "BTN", "SB", "BB"]

    height: 768
    title: "Ranges"
    visible: true
    width: 1024

    GridLayout {
        Layout.alignment: Qt.AlignTop
        anchors.fill: parent
        anchors.margins: 0
        columnSpacing: 10
        columns: 3
        rows: 5

        TabBar {
            id: versusBar
            Layout.alignment: Qt.AlignTop
            Layout.column: 1
            Layout.columnSpan: 3
            Layout.fillWidth: true
            Layout.row: 0

            Repeater {
                model: versuses

                TabButton {
                    text: modelData
                }
            }
        }
        Item {
            id: positionBar

            property int currentIndex

            Layout.alignment: Qt.AlignLeft
            Layout.column: 0
            Layout.fillWidth: true
            Layout.preferredWidth: 100
            Layout.row: 2

            ListView {
                id: positionsView
                height: positionsModel.count * 40

                delegate: Button {
                    text: model.text
                    highlighted: positionBar.currentIndex === index

                    onClicked: {
                        console.log(model.text, versusBar.currentIndex);
                        positionBar.currentIndex = index;
                        console.log(rangeListModel.currentIndex)
                    }
                }
                model: ListModel {
                    id: positionsModel
                    Component.onCompleted: {
                        for (const pos of positions) {
                            append({
                                    "text": pos
                                });
                        }
                    }
                }
            }
        }
        StackLayout {
            id: stack
            Layout.column: 1
            Layout.fillWidth: true
            Layout.preferredWidth: 40 * 13
            Layout.row: 1
            Layout.rowSpan: 4
            currentIndex: positionBar.currentIndex + versusBar.currentIndex*versuses.length

            Repeater {
                id: rangeRepeater
                delegate: Range {
                    position: model.position
                    versus: model.versus
                }
                model: ListModel {
                    id: rangeListModel
                    Component.onCompleted: {
                        for (const pos of positions) {
                            for (const versus of versuses) {
                                append({
                                        "position": pos,
                                        "versus": versus
                                    });
                            }
                        }
                    }
                }
            }
        }
        TextField {
            id: rangeText
            Layout.alignment: Qt.AlignLeft
            Layout.column: 2
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width - 40 * 13 - 100 - 10
            Layout.row: 1
            text: rangeRepeater.itemAt(stack.currentIndex).toText()

            onAccepted: {
                let range = rangeRepeater.itemAt(stack.currentIndex);
                range.clearCombos();
                console.log(actionButtons.actionList.currentItem.currentAction);
                range.setActionCombos(rangeText.text, actionButtons.currentAction);
            }
        }
        Text {
            id: nbCardsText
            function getText() {
                const range = rangeRepeater.itemAt(stack.currentIndex);
                const nbCards = range.nbCards();
                const percent = (nbCards * 100 / 1326).toFixed(2);
                return `${nbCards} cards (${percent}%)`;
            }

            Layout.column: 2
            Layout.fillWidth: true
            Layout.row: 2
            text: getText()
        }
        ActionButtons {
            id: actionButtons

            property string currentAction: actionList.currentItem.currentAction

            Layout.column: 2
            Layout.fillWidth: true
            Layout.row: 3
        }
    }
}