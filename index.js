const { app, BrowserWindow } = require('electron');

function createWindow () {
    let win = new BrowserWindow({
        width: 400,
        height: 200,
        webPreferences: {
            nodeIntegration: true
        }
    });
    win.loadFile('index.html');
}

app.whenReady().then(createWindow);

app.on('windows-all-closed', () => {
    if (process.platform !== 'darwin'){
        app.quit()
    }
})