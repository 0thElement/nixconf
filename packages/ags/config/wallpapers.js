const b = Variable(false)
const files = Variable("")
const configDir = Utils.exec(`bash -c "echo $NIXOS_CONFIG"`)
const dir = `${configDir}assets/wallpapers/`
const statePath = Utils.exec(`bash -c "echo $LAST_WALLPAPER_PATH"`)

function updateFiles() {
    files.value = Utils.exec(`ls -1 ${dir}`)
}

function setWallpaper(path) {
    const fullDir = `${dir}${path}`

    Utils.exec(`swww img --transition-type simple --transition-fps 60 ${fullDir}`)
    Utils.writeFile(fullDir, statePath)
    Utils.exec(`wpg -a ${fullDir} -n`)
    Utils.exec(`wpg -A ${path} -n`)
    Utils.exec(`wpg -s ${path} -n`)

    Utils.exec(`hyprctl reload`)
    App.resetCss()
    App.applyCss(`${App.configDir}/style.css`)
}

function closeWindow() {
    App.closeWindow('wallpaper')
    files.value = ""
}

function OpenWallpaper() {
    return Widget.Button({
        child: Widget.Icon({ icon: "starred" }),
        onClicked: () => {
            updateFiles()
            b.value = !b.value
            App.toggleWindow('wallpaper')
        }
    })
}

function Wallpaper(monitor = 0) {
    return Widget.Window({
        name: 'wallpaper',
        class_name: "wallpapers",
        monitor,
        anchor: ["bottom", "top", "left"],
        exclusivity: "exclusive",
        layer: "overlay",
        margins: [12, 0, 12, 12],
        visible: false,
        child: Widget.Scrollable({
            vscroll: "always",
            hscroll: "never",
            child: Widget.Box({
                class_name: 'wallpaperContainer',
                vertical: true,
                children: files.bind().as(x => x.split("\n")
                    .filter(x => x !== "")
                    .sort()
                    .map(path => ImagesList(path)))
            }),
        })
    })
}

function ImagesList(path) {
    return Widget.Button({
        class_name: 'wallpaperButton',
        onPrimaryClick: () => {
            closeWindow();
            setWallpaper(path)
        },
        child: Widget.Icon({
            class_name: 'wallpaperImage',
            size: 100,
            icon: `${dir}${path}`
        })
    })
}

export { OpenWallpaper, Wallpaper }
