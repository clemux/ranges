import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "main.js" as Functions

ApplicationWindow {
    property list<string> positions: ["HJ", "CO", "BTN", "SB", "BB"]

    height: 768
    title: "Ranges"
    visible: true
    width: 1024

    TabBar {
        id: bar
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Repeater {
            model: positions

            TabButton {
                text: modelData
            }
        }
    }
    StackLayout {
        currentIndex: bar.currentIndex
        height: parent.height - bar.height

        anchors {
            top: bar.bottom
        }
        Repeater {
            model: positions

            Range {
                position: modelData
            }
        }
    }
}