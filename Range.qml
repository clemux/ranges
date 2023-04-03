import QtQuick
import QtQuick.Controls
import "main.js" as Functions

Item {
    property var combos: Functions.combos()
    property string position

    function selectCombo(s) {
        let combo = Functions.findCombo(listModel, s);
        combo.isSelected = true;
    }
    function selectCombos(s) {
        let split = s.split(',');
        split.forEach(c => selectCombo(c.trim()));
    }
    function clearCombos() {
        for (let i = 0; i < listModel.count; i++) {
            listModel.get(i).isSelected = false
        }
    }
    function toText() {
        let s = "";
        for (let i = 0; i < listModel.count; i++) {
            const combo = listModel.get(i);
            if (combo.isSelected) {
                s += combo.text + ",";
            }
        }
        return s.replace(/,+$/, '');
    }

    function nbCards() {
        let n = 0
        for (let i = 0; i < listModel.count; i++) {
            const combo = listModel.get(i)
            if (combo.isSelected) {
                console.log(combo.text)
                n += combo.nbCards
            }
        }
        return n
    }


    ListModel {
        id: listModel
        Component.onCompleted: {
            for (const combo of combos) {
                listModel.append({
                    text: combo.toString(),
                    left: combo.left,
                    right: combo.right,
                    isSuited: combo.isSuited,
                    isSelected: combo.isSelected,
                    nbCards: combo.nbCards
                })
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