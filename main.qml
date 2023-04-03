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
            StackLayout {
                id: stack
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
                Layout.alignment: Qt.AlignTop
                text: rangeRepeater.itemAt(stack.currentIndex).toText();
            }
            Button {
                Layout.alignment: Qt.AlignTop
                text: "Select"

                onClicked: {
                    let range = rangeRepeater.itemAt(stack.currentIndex)
                    range.clearCombos()
                    range.selectCombos(rangeText.text);
                }
            }
        }
    }
}