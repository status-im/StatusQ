import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

StatusIcon {
    id: statusIcon
    icon: "loading"
    height: Theme.dp(17)
    width: Theme.dp(17)
    RotationAnimation {
        target: statusIcon;
        from: 0;
        to: 360;
        duration: 1200
        running: true
        loops: Animation.Infinite
    }
}

