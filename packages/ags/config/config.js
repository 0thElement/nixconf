// const notifications = await Service.import("notifications")
const hyprland = await Service.import("hyprland")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")
const network = await Service.import("network")
import { OpenWallpaper, Wallpaper } from "./wallpapers.js"

const mem = Variable(0, {
    poll: [5000, App.configDir + '/mem.sh']
})

const cpu = Variable(0, {
    poll: [5000, App.configDir + '/cpu.sh']
})

const time = Variable("", {
    poll: [1000, 'date "+%H\n%M"'],
})

const date = Variable("", {
    poll: [1000, 'date "+%d/%m\n%A"'],
})

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["left", "top", "bottom"],
        exclusivity: "exclusive",
        margins: [0, 0, 0, 0],
        child: Widget.CenterBox({
            class_name: "container",
            vertical: true,
            start_widget: Top(),
            end_widget: Bottom(),
        }),
    })
}

App.config({
    style: "./style.css",
    windows: [
        Bar(),
        Wallpaper(),
    ],
})

function Top() {
    return Widget.Box({
        spacing: 8,
        vertical: true,
        children: [
            Volume(),
            Cpu(),
            Memory(),
            Battery(),
            Workspaces(),
        ],
    })
}

function Bottom() {
    return Widget.Box({
        vpack: "end",
        spacing: 8,
        vertical: true,
        children: [
            SysTray(),
            Bluetooth(),
            Network(),
            OpenWallpaper(),
            Time(),
            Date(),
            // Notification(),
        ],
    })
}

function Workspaces() {
    const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);
    return Widget.Box({
        class_name: "workspaces",
        vertical: true,
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            attribute: i,
            label: `${i}`,
            onClicked: () => dispatch(i),
        })),

        setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
            btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute);
            btn.toggleClassName("focused", hyprland.active.workspace.id == btn.attribute);
        })),
    })
}

function Time() {
    return Widget.Label({
        class_name: "time",
        label: time.bind(),
    })
}

function Date() {
    return Widget.Label({
        class_name: "date",
        label: date.bind(),
    })
}

// function Notification() {
//     const popups = notifications.bind("popups")
//     return Widget.Box({
//         class_name: "notification",
//         visible: popups.as(p => p.length > 0),
//         children: [
//             Widget.Icon({
//                 icon: "preferences-system-notifications-symbolic",
//             }),
//             Widget.Label({
//                 label: popups.as(p => p[0]?.summary || ""),
//             }),
//         ],
//     })
// }

function Volume() {
    const icons = {
        67: "overamplified",
        34: "high",
        1: "medium",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        size: 12,
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    return Widget.Box({
        class_name: "volume",
        vertical: true,
        children: [
            Widget.CircularProgress({
                rounded: true,
                startAt: 0.75,
                value: Utils.watch(0, audio.speaker, () => audio.speaker.volume),
                class_name: "circular",
                child: icon
            })
        ],
    })
}

function Memory() {
    return Widget.Box({
        class_name: "memory",
        vertical: true,
        children: [
            Widget.CircularProgress({
                rounded: true,
                startAt: 0.75,
                value: mem.bind().as(x => x / 100),
                class_name: "circular",
                child: Widget.Icon({ icon: "memory", size: 11 })
            })
        ],
    })
}

function Cpu() {
    return Widget.Box({
        class_name: "cpu",
        vertical: true,
        children: [
            Widget.CircularProgress({
                rounded: true,
                startAt: 0.75,
                value: cpu.bind().as(x => x / 100),
                class_name: "circular",
                child: Widget.Icon({ icon: "cpu", size: 10 })
            })
        ],
    })
}


function Battery() {
    const value = Utils.merge([battery.bind("percent"), battery.bind("available")],
        (p, a) => !a ? 100 : p > 0 ? p / 100 : 0)

    return Widget.Box({
        class_name: "battery",
        vertical: true,
        children: [
            Widget.CircularProgress({
                rounded: true,
                startAt: 0.75,
                value: value,
                class_name: "circular",
                child: Widget.Icon({
                    icon: battery.bind("available").as(x => `${x ? "battery" : "battery-missing"}`),
                    size: 10
                })
            })
        ],
    })
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            class_name: "trayicon",
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        class_name: "tray",
        children: items,
        vertical: true,
    })
}

function Bluetooth() {
    return Widget.Box({
        class_name: "sysicon",
        vertical: true,
        children: [
            Widget.Button({
                class_name: "bluetooth",
                child: Widget.Icon("bluetooth-active"),
                on_primary_click: (_, __) => Utils.subprocess(['blueman-manager'])
            })
        ],
    })
}

function WifiIndicator() {
    return Widget.Icon({
        icon: network.wifi.bind('icon_name'),
    })
}

function WiredIndicator() {
    return Widget.Icon({
        icon: network.wired.bind('icon_name'),
    })
}

function Network() {
    return Widget.Box({
        class_name: "sysicon",
        vertical: true,
        children: [
            Widget.Button({
                class_name: "network",
                child: Widget.Stack({
                    children: {
                        wifi: WifiIndicator(),
                        wired: WiredIndicator(),
                    },
                    shown: network.bind('primary').as(p => p || 'wifi'),
                }),
                on_primary_click: (_, __) => Utils.subprocess(['nm-connection-editor'])
            })
        ],
    })
}

export { }
