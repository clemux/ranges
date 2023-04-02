import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "main.js" as Functions

ApplicationWindow {
    height: 768
    title: "Ranges"
    visible: true
    width: 1024

    MouseArea {
        anchors.fill: parent

        Grid {
            id: grid
            columns: 13
            rows: 13
            spacing: 4

            Repeater {
                model: Functions.combos()

                Combo {
                    comboCards: modelData
                }
            }
        }
    }
}