#!/bin/bash

# AUTO-GENERATED FILE

brew_command=/usr/local/bin/brew
brew_cask_command="$brew_command cask"

failed_items=""

function install_package() {
    echo EXECUTING: brew install $1 $2
    $brew_command install $1 $2
    [ $? -ne 0 ] && $failed_items="$failed_items $1"  # package failed to install.
}

function install_cask_package() {
    echo EXECUTING: brew cask install $1
    $brew_cask_command install $1
    [ $? -ne 0 ] && $failed_items="$failed_items $1"  # package failed to install.
}

# Taps
/usr/local/bin/brew tap caskroom/cask
/usr/local/bin/brew tap caskroom/versions
/usr/local/bin/brew tap homebrew/core
/usr/local/bin/brew tap homebrew/headonly
/usr/local/bin/brew tap homebrew/python
/usr/local/bin/brew tap neovim/neovim

# Formulas
install_package android-sdk ''
install_package autoconf ''
install_package automake ''
install_package boost ''
install_package cmake ''
install_package coreutils ''
install_package cscope ''
install_package ctags ''
install_package emacs ''
install_package fontconfig ''
install_package freetype ''
install_package gcc ''
install_package gd ''
install_package gdbm ''
install_package gettext ''
install_package git ''
install_package gmp ''
install_package gnutls ''
install_package gradle ''
install_package isl ''
install_package jasper ''
install_package jpeg ''
install_package libevent ''
install_package libgphoto2 ''
install_package libicns ''
install_package libmpc ''
install_package libpng ''
install_package libtasn1 ''
install_package libtiff ''
install_package libtool ''
install_package libusb ''
install_package libusb-compat ''
install_package little-cms2 ''
install_package macvim ''
install_package makedepend ''
install_package maven ''
install_package mercurial ''
install_package mobile-shell ''
install_package mongodb ''
install_package mpfr ''
install_package neo4j ''
install_package neovim ''
install_package nettle ''
install_package node ''
install_package openssl ''
install_package pcre ''
install_package pkg-config ''
install_package portmidi ''
install_package protobuf ''
install_package pyenv ''
install_package python ''
install_package python3 ''
install_package readline ''
install_package sane-backends ''
install_package sdl ''
install_package sdl_image ''
install_package sdl_mixer ''
install_package sdl_ttf ''
install_package smpeg ''
install_package sqlite ''
install_package stow ''
install_package tmux ''
install_package tree ''
install_package unar ''
install_package webp ''
install_package wine ''
install_package xz ''
install_package zsh ''
install_package zsh-completions ''

# Casks
install_cask_package 1password
install_cask_package atom
install_cask_package basictex
install_cask_package candybar
install_cask_package disk-inventory-x
install_cask_package dropbox
install_cask_package firefox
install_cask_package flux
install_cask_package google-chrome
install_cask_package intellij-idea-ce
install_cask_package iterm2
install_cask_package iterm2-nightly
install_cask_package java
install_cask_package prey
install_cask_package rescuetime
install_cask_package slack
install_cask_package sublime-text3
install_cask_package ubersicht
install_cask_package utorrent
install_cask_package vlc

[ ! -z $failed_items ] && echo The following items failed to install: && echo $failed_items