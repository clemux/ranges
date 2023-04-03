import QtQuick

Item {
    id: combo
    property alias comboColor: rectangle.color

    height: 40
    width: 40

    Rectangle {
        id: rectangle
        anchors.fill: parent
        border.color: "white"
        color: model.isSelected ? "green" : "lightyellow"

        Text {
            id: comboText
            padding: 10
            text: model.text
        }
    }
    MouseArea {
        anchors.fill: parent

        onClicked: {
            model.isSelected = !model.isSelected
        }
    }
}