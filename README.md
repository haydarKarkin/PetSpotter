 [![Generic badge](https://img.shields.io/badge/Language-Swift-red.svg)](https://developer.apple.com/swift/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Pet Spotter
![](https://github.com/haydarKarkin/PetSpotter/blob/main/images/mockup.jpg)

## Table of Contents
- <a href="#about">About</a>
- <a href="#Introduction">Introduction</a>
- <a href="#app-features">Application Features</a>
- <a href="#requirements">Requirements</a>
- <a href="#tech">Tech</a>
- <a href="#license">License</a>

## About
Some animals require adoption to avoid dumping or overloading at the shelter. Pet finder apps are required to speed up pet meeting with adopters.

## Introduction

## Application Features
### Animals Scene


### Filter Scene


### Animal Detail Scene


### Favorites Scene


### Orgaizations Scene


### Organization Detail Scene


## Requirements

- Xcode: Version 13.0
- Language: Swift 5
- Minimum iOS Version: 14
- Device Orientation: Portrait Mode

## Tech

### Architecture
This project is designed by MVVM-C architecture pattern where:

![](https://github.com/haydarKarkin/PetSpotter/blob/main/images/mvvm-c.jpg)

- View is represented by `UIViewController` designed in Storyboard
- Model represents state and domain objects
- ViewModel interacts with Model and prepares data to be displayed. View uses ViewModel's data either directly or through bindings (using Closures) to configure itself. View also notifies ViewModel about user actions like button tap. ViewModels transform inputs from view and return an output object that holds data/actions.
- Service layer is where the logic of dealing with responses from the network request is handled. ViewModels should interface this layer to get updated data as necessary.
- Coordinator is responsible for handling application flow, decides when and where to go based on events from ViewModel (trigers routing functions).

`View` <- `ViewController` <- bindings -> (`ViewModel` -> `Model`) <- trigers -> `Coordinator`

### Project Structure

### Networking

### Persisten Data


## License
```
Copyright (c) 2021 Haydar Karkin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```