import QtQuick

Item {
    id: combo
    property string leftCard
    property string rightCard
    property bool isSuited
    property alias comboColor: rectangle.color
    property bool selected: false

    property string uniqueId
    height: 40
    width: 40

    Rectangle {
        id: rectangle
        anchors.fill: parent
        border.color: "white"
        color: combo.selected ? "green" : "lightyellow"

        Text {
            id: comboText
            padding: 10
            text: leftCard + rightCard + (leftCard === rightCard ? "" : (isSuited ? "s" : "o"))
        }
    }
    MouseArea {
        anchors.fill: parent

        onClicked: {
            selected = !selected
        }
    }
}