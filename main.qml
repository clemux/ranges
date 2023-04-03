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
            TextField {
                id: rangeText
                text: rangeRepeater.itemAt(stack.currentIndex).toText()

                onAccepted: {
                    let range = rangeRepeater.itemAt(stack.currentIndex);
                    range.clearCombos();
                    range.selectCombos(rangeText.text);
                }
            }
            ComboBox {
                model: ["RFI", "Call", "3Bet"]
            }
            Text {
                id: nbCardsText
                text: getText()

                function getText() {
                    const range = rangeRepeater.itemAt(stack.currentIndex)
                    const nbCards = range.nbCards()
                    const percent = (nbCards * 100 / 1326).toFixed(2)
                    return `${nbCards} (${percent}%)`
                }
            }
        }
    }
}