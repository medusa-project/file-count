const electron = require('electron');
const pug = require('electron-pug')({pretty: true});
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

app.on('ready', () => {
  var mainWindow = new BrowserWindow({width: 800, height: 600});
  mainWindow.loadURL('file://' + __dirname + '/index.html');
  //mainWindow.webContents.openDevTools();
});