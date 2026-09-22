import Quickshell
import QtQuick
import QtQuick.Controls

FloatingWindow {
    id: note

    title: "Shalidor Note"

    width: 360
    height: 420

    color: "#1a1a1a"

    TextArea {
        anchors.fill: parent
        anchors.margins: 20

        placeholderText: "Write something..."
        wrapMode: TextArea.Wrap

        color: "#eeeeee"
        placeholderTextColor: "#777777"

        font.family: "JetBrains Mono"
        font.pixelSize: 15

        background: Rectangle {
            color: "transparent"
        }
    }
}
