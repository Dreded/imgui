#!/bin/bash

storage_folder='glfw_only'

mkdir $storage_folder

mkdir $storage_folder/imgui
mv *.txt *.h *.cpp $storage_folder/imgui

mkdir $storage_folder/backend_glfw
mv ./backends/*opengl3* ./backends/*glfw* $storage_folder/backend_glfw/

rm -rf backends

mkdir $storage_folder/src
mv ./examples/example_glfw_opengl3/main.cpp ./examples/example_glfw_opengl3/Makefile $storage_folder/src/

{   rm -rf *
    tar -x
} <<TAR
$(tar -c $storage_folder)
TAR