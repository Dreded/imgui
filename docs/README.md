This fork exists to add a bash script to get IMGUI up and running on linux with GLFW3 and OpenGL3 and removes everything else not needed.

## Install
```
git clone https://github.com/Dreded/imgui myImGUIApp
cd myImGUIApp
./only_glfw.sh
```
When done it deletes everything not neccesary including the script and the .git folder removing association from this project. You can delete the misc folder if desired, I left it incase you want the font examples etc.

## Compile
```
cd src
make
```

## Run
```
./myApp
```

### Current Fully Supported Distros
* Arch w/X11 (script suggests pacman to install GLFW)

Will work for other distros just no full instructions(will need to figure out GLFW install)

###### Original Readme = docs/README_ORIGINAL.md
