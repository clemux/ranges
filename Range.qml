import QtQuick
import QtQuick.Controls
import "main.js" as Functions

Item {
    property var combos: Functions.combos()
    property string position

    function getComboIndex(s) {
        return index;
    }
    function selectCombo(s) {
        let combo = Functions.getCombo(listModel, s);
        combo.isSelected = true
    }
    function selectCombos(s) {
        let split = s.split(',');
        split.forEach(c => selectCombo(c.trim()));
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
        id: delegate
        Combo {
            isSelected: model.isSelected
            isSuited: model.isSuited
            leftCard: model.left
            rightCard: model.right
        }
    }
    GridView {
        id: range
        cellHeight: 40
        cellWidth: 40
        delegate: delegate
        height: 40 * 13
        model: listModel
        width: 40 * 13
    }
}