// Omarchy's login theme with a username field added, for shared machines.
// Reuses Omarchy's images so branding follows Omarchy updates.
import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
  id: root
  width: 640
  height: 480
  color: "#1a1b26"

  readonly property string art: "file:///usr/share/sddm/themes/omarchy/"
  property bool loginFailed: false
  property int sessionIndex: {
    for (var i = 0; i < sessionModel.rowCount(); i++) {
      var name = (sessionModel.data(sessionModel.index(i, 0), Qt.DisplayRole) || "").toString()
      if (name.indexOf("uwsm") !== -1)
        return i
    }
    return sessionModel.lastIndex
  }

  function login() {
    if (username.text.trim() === "") {
      username.forceActiveFocus()
      return
    }
    sddm.login(username.text.trim().toLowerCase(), password.text, root.sessionIndex)
  }

  Connections {
    target: sddm
    function onLoginFailed() {
      root.loginFailed = true
      password.text = ""
      password.forceActiveFocus()
    }
    function onLoginSucceeded() {
      root.loginFailed = false
    }
  }

  Column {
    anchors.centerIn: parent
    spacing: 24

    Image {
      source: root.art + "logo.png"
      width: Math.min(sourceSize.width, root.width * 0.8)
      height: sourceSize.width > 0 ? Math.round(width * sourceSize.height / sourceSize.width) : 0
      fillMode: Image.PreserveAspectFit
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Item { width: 1; height: 16 }

    // Username
    Item {
      width: userEntry.width
      height: userEntry.height
      anchors.horizontalCenter: parent.horizontalCenter

      Image {
        id: userEntry
        source: root.art + (root.loginFailed ? "entry-failed.png" : "entry.png")
        anchors.centerIn: parent
      }

      Text {
        text: "username"
        visible: username.text === ""
        color: "#565f89"
        font: username.font
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
      }

      TextInput {
        id: username
        objectName: "username"
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        verticalAlignment: TextInput.AlignVCenter
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 24
        color: "#c0caf5"
        selectionColor: "#33467c"
        clip: true
        focus: true
        KeyNavigation.tab: password
        onTextChanged: root.loginFailed = false
        Keys.onPressed: {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            password.forceActiveFocus()
            event.accepted = true
          }
        }
      }
    }

    // Password (same look as Omarchy's: bullets drawn as images)
    Item {
      width: passEntry.width
      height: passEntry.height
      anchors.horizontalCenter: parent.horizontalCenter

      Image {
        id: passEntry
        source: root.art + (root.loginFailed ? "entry-failed.png" : "entry.png")
        anchors.centerIn: parent
      }

      Text {
        text: "password"
        visible: password.text === ""
        color: "#565f89"
        font: username.font
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
      }

      Row {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Repeater {
          model: Math.min(password.text.length, 21)

          Image {
            source: root.art + "bullet.png"
            width: 7
            height: 7
          }
        }
      }

      TextInput {
        id: password
        objectName: "password"
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        verticalAlignment: TextInput.AlignVCenter
        echoMode: TextInput.Password
        font.pixelSize: 24
        color: "transparent"
        selectionColor: "transparent"
        selectedTextColor: "transparent"
        cursorDelegate: Item {}
        KeyNavigation.backtab: username
        onTextChanged: root.loginFailed = false
        Keys.onPressed: {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            root.login()
            event.accepted = true
          }
        }
      }
    }
  }

  Component.onCompleted: username.forceActiveFocus()
}
