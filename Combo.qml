import QtQuick

Item {
    id: combo

    property alias comboCards: comboText.text
    property alias comboColor: rectangle.color
    property bool selected: false

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
        }
    }
    MouseArea {
        anchors.fill: parent

        onClicked: {
            selected = !selected
        }
    }
}