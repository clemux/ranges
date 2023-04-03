import QtQuick
import QtQuick.Controls
import "main.js" as Functions

Item {
    property var combos: Functions.combos()
    property string position

    function selectCombo(s) {
        let combo = Functions.findCombo(listModel, s);
        console.log(combo);
        combo.isSelected = true;
    }
    function selectCombos(s) {
        let split = s.split(',');
        split.forEach(c => selectCombo(c.trim()));
    }
    function toText() {
        let s = "";
        for (let i = 0; i < listModel.count; i++) {
            const combo = listModel.get(i);
            if (combo.isSelected) {
                s += combo.left + combo.right + ",";
            }
        }
        return s.replace(/,+$/, '');
    }

    ListModel {
        id: listModel
        Component.onCompleted: {
            for (const combo of combos) {
                listModel.append({
                        "left": combo.left,
                        "right": combo.right,
                        "isSuited": combo.isSuited,
                        "isSelected": combo.isSelected
                    });
            }
        }
    }
    Component {
        id: comboDelegate
        Combo {
        }
    }
    GridView {
        id: range
        cellHeight: 40
        cellWidth: 40
        delegate: comboDelegate
        height: 40 * 13
        model: listModel
        width: 40 * 13
    }
}