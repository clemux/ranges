import QtQuick
import "main.js" as Functions

Item {
    property string position
    Grid {
        id: range
        columns: 13
        rows: 13
        spacing: 4

        Repeater {
            model: Functions.combos()

            Combo {
                leftCard: {
                    modelData[0]
                }
                rightCard: modelData[1]
                isSuited: modelData[2]
            }
        }
    }
}