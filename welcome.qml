import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1 as Platform

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: "Welcome to KosmOS"

    property bool darkTheme:    window.palette.window.r < 0.5 &&
                                window.palette.window.g < 0.5 &&
                                window.palette.window.b < 0.5

    //property bool dontShowAgain: false

    property string configPath: {
        var url = String(Platform.StandardPaths.writableLocation(Platform.StandardPaths.ConfigLocation))
        return url.replace(/^file:\/\//, "")
    }

    Settings {
        id: kosmosWelcomeSettings
        fileName: configPath + "/kosmos-welcome.conf"
        property bool dontShowAgain: false
    }

    // Imposta lo stile Fusion (opzionale ma coerente)
    Component.onCompleted: Qt.callLater(function() {
        Qt.application.style = "Fusion"
    })

    Rectangle {
        anchors.fill: parent
        // Usa la palette del window (Qt5)
        color: window.palette.window
        border.color: window.palette.mid

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 24
            width: parent.width * 0.8

            Image {
                source: darkTheme ?
                    "file:///usr/share/pixmaps/kosmos-logo-dark.png" :
                    "file:///usr/share/pixmaps/kosmos-logo-light.png"
                width: 256
                height: 72
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "Setup completed. System is ready to use!"
                font.pointSize: 14
                color: window.palette.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                textFormat: Text.RichText
                text: darkTheme ?
                "KosmOS is configured now with its <b><i>KosmOS Dark</i></b> theme, thought to preserve <i>dark eye adaptation</i>. KosmOS provides also a light theme: press the button <i>Theme selector</i> below and select <b><i>KosmOS Light</i></b> (or any other theme, at your option) to switch. You can always reach the theme selector launching <i>System Settings</i> and selecting <i>Appearance</i>." :
                "KosmOS is configured now with its <b><i>KosmOS Light</i></b> theme. KosmOS provides also a dark theme, thought to preserve <i>dark eye adaptation</i>: press the button <i>Theme selector</i> below and select <b><i>KosmOS Dark</i></b> (or any other theme, at your option) to switch. You can always reach the theme selector launching <i>System Settings</i> and selecting <i>Appearance</i>."
                font.pointSize: 10
                color: window.palette.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 540
            }

            Label {
                textFormat: Text.RichText
                text: "<b>INDI</b>, <b>KStars</b> and <b>PHD2</b> are already installed and ready to start. Please be warned that, to save disk space, <b>INDI 3rd-party</b> drivers are <b>not</b> installed at the moment: please read the instructions clicking the button <i>INDI 3rd-party</i> below to install the ones you need."
                font.pointSize: 10
                color: window.palette.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 540
            }

            RowLayout {
                spacing: 16
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: "Theme selector..."
                    onClicked: Qt.openUrlExternally("systemsettings://kcm_lookandfeel")
                    font.pointSize: 11
                }

                Button {
                    text: "INDI 3rd-party..."
                    onClicked: Qt.openUrlExternally("file:///usr/share/doc/kosmos-welcome/installing-indi-3rdparty.html")
                    font.pointSize: 11
                }

                Button {
                    text: "Visit KosmOS website..."
                    onClicked: Qt.openUrlExternally("https://kosmos-pi.org")
                    font.pointSize: 11
                }

                Button {
                    text: "Close"
                    onClicked: Qt.quit()
                    font.pointSize: 11
                }
            }

            Label {
                text: "Kosmos © 2025"
                font.pointSize: 10
                color: "#808080"
                opacity: 1.0
                Layout.alignment: Qt.AlignHCenter
            }

            CheckBox {
                id: chk
                text: "Don't show this window again"
                checked: kosmosWelcomeSettings.dontShowAgain
                onToggled: kosmosWelcomeSettings.dontShowAgain = checked
            }

        }
    }
}
