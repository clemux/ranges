import QtQuick
import QtQuick.Controls
import "main.js" as Functions

Item {
    property string position
    property var combos: Functions.combos()

    function getComboIndex(s) {
        let index = Functions.getCombo(combos, s)
        return index
    }

    function selectCombo(s) {
        const index = getComboIndex(s)
        comboRepeater.itemAt(index).isSelected = true
    }

    function selectCombos(s) {
        let split = s.split(',')
        split.forEach(c => selectCombo(c.trim()))
    }

    Grid {
        id: range
        columns: 13
        rows: 13
        spacing: 4

        Repeater {
            model: combos
            id: comboRepeater

            Combo {
                leftCard: modelData.left
                rightCard: modelData.right
                isSuited: modelData.isSuited
                isSelected: modelData.isSelected
            }
        }
    }
}