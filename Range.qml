import QtQuick
import QtQuick.Controls
import "main.js" as Functions

Item {
    visible: false
    property var combos: Functions.combos()
    property string position
    property string versus

    function setActionCombo(s, action) {
        let combo = Functions.findCombo(listModel, s);
        combo.action = action;
    }
    function setActionCombos(comboText, action) {
        let split = comboText.split(',');
        split.forEach(c => setActionCombo(c.trim(), action));
    }
    function clearCombos() {
        for (let i = 0; i < listModel.count; i++) {
            listModel.get(i).action = "fold"
        }
    }
    function toText() {
        let s = "";
        for (let i = 0; i < listModel.count; i++) {
            const combo = listModel.get(i);
            if (combo.action !== "fold") {
                s += combo.text + ",";
            }
        }
        return s.replace(/,+$/, '');
    }

    function nbCards() {
        let n = 0
        for (let i = 0; i < listModel.count; i++) {
            const combo = listModel.get(i)
            if (combo.action !== "fold") {
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
                    action: combo.action,
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
    Component.onCompleted: {
        console.log(`Range ${position} ${versus}`)
        if (position === versus) {
            range.visible = false
        }
    }
}