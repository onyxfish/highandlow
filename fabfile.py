#!/usr/bin/env python

from fabric.api import local 

def setup():
    local('haxelib install lime')
    local('haxelib run lime setup')
    local('lime install openfl')
    local('haxelib install flixel')

def test():
    local('lime test neko')
    
def debugger():
    """
    Run with in-game debugger.
    (Prevents command-line logging.)
    """
    local('lime -debug test neko')

def mac():
    local('lime test mac')
