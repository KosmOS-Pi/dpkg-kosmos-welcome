import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.settings
import Qt.labs.platform as Platform

ApplicationWindow {
    id: window
    width: 720  // Aumentato da 640 a 720 per accomodare i margini di Qt6
    height: 520 // Aumentato leggermente da 480 a 520 per dare più respiro verticale
    visible: true
    title: "Welcome to KosmOS"

    property bool darkTheme: {
        if (window.palette && window.palette.window) {
            return window.palette.window.r < 0.5;
        }
        return true;
    }

    property string configPath: {
        var url = String(Platform.StandardPaths.writableLocation(Platform.StandardPaths.ConfigLocation))
        return url.replace(/^file:\/\//, "")
    }

    Settings {
        id: kosmosWelcomeSettings
        fileName: configPath + "/kosmos-welcome.conf"
        property bool dontShowAgain: false
    }

    Rectangle {
        anchors.fill: parent
        color: window.palette.window
        border.color: window.palette.mid

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20
            width: parent.width * 0.9 // Leggermente allargato per sfruttare meglio lo spazio

            Image {
                source: darkTheme ?
                "file:///usr/share/pixmaps/kosmos-logo-dark.png" :
                "file:///usr/share/pixmaps/kosmos-logo-light.png"
                width: 256
                height: 72
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "Setup completed. System is ready to use!"
                font.pointSize: 14
                color: window.palette.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
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
                Layout.fillWidth: true
                Layout.maximumWidth: 600
            }

            Label {
                textFormat: Text.RichText
                text: "<b>INDI</b>, <b>KStars</b> and <b>PHD2</b> are already installed and ready to start. Please be warned that, to save disk space, <b>INDI 3rd-party</b> drivers and <b>astrometry indexes</b> are <b>not installed</b> at the moment. To learn more about this, and for other useful details to help you get started, press the button <i>Getting started...</i> below and read the document."
                font.pointSize: 10
                color: window.palette.text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.maximumWidth: 600
            }

            // RISOLUTIVO: Il RowLayout ora si adatta alla larghezza disponibile
            RowLayout {
                spacing: 12
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                // Un elemento vuoto a sinistra e uno a destra creano una centratura elastica perfetta in Qt6
                Item { Layout.fillWidth: true }

                Button {
                    text: "Theme selector..."
                    onClicked: Qt.openUrlExternally("systemsettings://kcm_lookandfeel")
                    font.pointSize: 10 // Ridotto leggermente a 10 per uniformità visiva in Qt6
                }

                Button {
                    text: "Getting started..."
                    onClicked: Qt.openUrlExternally("file:///usr/share/doc/kosmos-welcome/kosmos-getting-started-guide.html")
                    font.pointSize: 10
                }

                Button {
                    text: "Visit KosmOS website..."
                    onClicked: Qt.openUrlExternally("https://kosmos-pi.org")
                    font.pointSize: 10
                }

                Button {
                    text: "Close"
                    onClicked: Qt.quit()
                    font.pointSize: 10
                }

                Item { Layout.fillWidth: true }
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
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
