import QtQuick
import "main.js" as Functions
Grid {
    id: range
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
