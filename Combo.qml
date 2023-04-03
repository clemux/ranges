import QtQuick

Item {
    id: combo
    property alias comboColor: rectangle.color

    height: 40
    width: 40

    function setAction(action) {
        model.action = action
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent
        border.color: "white"
        color: {
            if (model.action === "rfi")
                return "green"
            else if (model.action === "call")
                return "orange"
            else if (model.action === "3bet")
                return "red"
            else return  "lightyellow"
        }

        Text {
            id: comboText
            padding: 10
            text: model.text
        }
    }
    MouseArea {
        anchors.fill: parent

        onClicked: {
            let actionList = actionButtons.actionList
            let action = actionList.currentItem.currentAction
            if (model.action === action) model.action = "fold"
            else model.action = action
        }
    }
}