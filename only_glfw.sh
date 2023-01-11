#!/bin/zsh

storage_folder='glfw_only'

mkdir $storage_folder

mv misc $storage_folder

mkdir $storage_folder/imgui
mv *.txt *.h *.cpp $storage_folder/imgui

mkdir $storage_folder/backend_glfw
mv ./backends/*opengl3* ./backends/*glfw* $storage_folder/backend_glfw/

mkdir $storage_folder/src
mv ./examples/example_glfw_opengl3/main.cpp ./examples/example_glfw_opengl3/Makefile $storage_folder/src/

{   rm -rf *
    rm -rf .git
    rm -rf .github
    rm -f .editorconfig
    tar -x
} <<TAR
$(tar -c $storage_folder)
TAR
mv ./$storage_folder/* .
rm -rf $storage_folder

# replace lines in makefile for new environment
sed -i 's/EXE = example_glfw_opengl3/EXE = myApp/;s#IMGUI_DIR = \.\./\.\.#IMGUI_DIR = \.\./imgui#;s#$(IMGUI_DIR)/backends#\.\./backend_glfw#g;s#OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))#OBJ_DIR = bin\nOBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(basename $(notdir $(SOURCES)))))#;s/%.o:/$(OBJ_DIR)\/%.o:/;s/all: \$/all: out_folder \$/;/@echo Build complete for $(ECHO_MESSAGE)/a\\nout_folder:\n\t@mkdir -p $(OBJ_DIR)' ./src/Makefile

windowManager=$(loginctl show-session `loginctl|grep $USER|awk '{print $1}'` -p Type)
windowManager=${windowManager#*=}
glfwPackage=glfw-$windowManager

if [ -f "/etc/arch-release" ]; then
  if pacman -Qi $glfwPackage >> /dev/null; then
   echo Your system GLFW Library is Installed.
  else
    echo Your system GLFW Library is not Installed.
    echo -e "  make will fail."
    echo -e "run:\n  sudo pacman -S $glfwPackage"
  fi
else
  echo "Please Install GLFW for your system"
fi

echo -e '\nDone, To make the demo...'
echo -e '  cd src'
echo -e '  make'
echo -e '\nThen modify as needed.'