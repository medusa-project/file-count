electron = require('electron')
remote = electron.remote
dialog = remote.dialog
fs = require('fs')

selectDirectoryLink = document.querySelector('#pick-directory')
selectedDirectorySpan = document.querySelector('#selected-directory')
runLink = document.querySelector('#run')
totalFilesCell = document.querySelector('#total-files')
relevantFilesCell = document.querySelector('#relevant-files')
skippedFilesCell = document.querySelector('#skipped-files')
excludedFilesCell = document.querySelector('#excluded-files')

totalFiles = null;
relevantFiles = null;
selectedDirectory = null
excludedFiles = ['Thumbs.db', '.DS_Store']
excludedFilesCell.innerHTML = excludedFiles.join(", ")

selectDirectoryLink.onclick = () ->
  dirs = dialog.showOpenDialog(properties: ['openDirectory'])
  selectedDirectory = dirs[0]
  selectedDirectorySpan.innerHTML = dirs[0]

runLink.onclick = () ->
  verifySelectedDirectory()
  resetFileCounts()
  updateFileCountDisplay()
  analyzeSelectedDirectory()

resetFileCounts = () ->
  totalFiles = 0
  relevantFiles = 0

updateFileCountDisplay = () ->
  totalFilesCell.innerHTML = totalFiles
  relevantFilesCell.innerHTML = relevantFiles
  skippedFilesCell.innerHTML = totalFiles - relevantFiles

verifySelectedDirectory = () ->
  okay = false
  try
    okay = fs.statSync(selectedDirectory).isDirectory()
  finally
    alert("Bad directory selected: #{selectedDirectory}") if !okay

analyzeSelectedDirectory = () ->
  directoryStack = [selectedDirectory]
  currentDirectory = null;
  while (currentDirectory = directoryStack.pop())
    for entry in fs.readdirSync(currentDirectory)
      full_entry = currentDirectory + '/' + entry
      stat = fs.lstatSync(full_entry)
      if stat.isDirectory()
        directoryStack.push(full_entry)
      else if stat.isFile()
        totalFiles += 1
        relevantFiles += 1 if isRelevant(entry)
    updateFileCountDisplay()

isRelevant = (entry) ->
  !excludedFiles.includes(entry)
