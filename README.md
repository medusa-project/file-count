This is a crude file count utility, useful because it will count
with exclusions. In our case we want to exclude
Thumbs.db and .DS_Store. 

Implemented in Electron. Assuming you have node installed, 
Do 

    npm install

to install the necessary packages and then to run:

    npm start
    
Pick a directory and press 'Analyze Directory' and 
you get a count of total files, skipped files, and 
relevant files. 

Files in .asar archives seem to be counted, not the 
archive itself. This may cause a discrepancy with other
tools (like find | wc), but for our purposes
shouldn't matter.

There are obvious ways this could be generalized and
improved, but we have no need to do so right now.

It should be possible to package and use this with electron-packager
or the like.