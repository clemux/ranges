import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Item {
    id: positionBar

    property int currentIndex: 0


    ListView {
        id: positionsView
        height: positionsModel.count * 40

        delegate: Button {
            highlighted: positionBar.currentIndex === index
            text: model.text
            width: 100

            onClicked: {
                positionBar.currentIndex = index;
            }
        }
        model: ListModel {
            id: positionsModel
            Component.onCompleted: {
                for (const pos of positions) {
                    append({
                            "text": pos
                        });
                }
            }
        }
    }
}
