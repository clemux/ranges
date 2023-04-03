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
        Layout.alignment: Qt.AlignTop
        anchors.fill: parent
        anchors.margins: 0
        columns: 2
        rows: 4
        columnSpacing: 0
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
            Layout.row: 1
            Layout.rowSpan: 4
            Layout.column: 0
            Layout.fillWidth: true
            Layout.preferredWidth: 40*13
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
            Layout.column: 1
            Layout.row: 1
            Layout.alignment: Qt.AlignLeft
            id: rangeText
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width - 40*13
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
            Layout.fillWidth: true
            id: nbCardsText
            function getText() {
                const range = rangeRepeater.itemAt(stack.currentIndex);
                const nbCards = range.nbCards();
                const percent = (nbCards * 100 / 1326).toFixed(2);
                return `${nbCards} cards (${percent}%)`;
            }

            text: getText()
        }
        ActionButtons {
            Layout.column: 1
            Layout.row: 3
            Layout.fillWidth: true
            id: actionButtons
        }

    }
}