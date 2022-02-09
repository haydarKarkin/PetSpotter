# Pet Spotter
Some animals require adoption to avoid dumping or overloading at the shelter. Pet finder apps are required to speed up pet meeting with adopters.

## Introduction

## Application Features
### Animals Scene


### Filter Scene


### Animal Detail Scene


### Favorites Scene


### Orgaizations Scene


### Organization Detail Scene


## Tech
## Architecture
This project is designed by MVVM-C architecture pattern where:

![](https://github.com/haydarKarkin/PetSpotter/blob/main/images/mvvm-c.jpg)

- View is represented by `UIViewController` designed in Storyboard
- Model represents state and domain objects
- ViewModel interacts with Model and prepares data to be displayed. View uses ViewModel's data either directly or through bindings (using Closures) to configure itself. View also notifies ViewModel about user actions like button tap. ViewModels transform inputs from view and return an output object that holds data/actions.
- Service layer is where the logic of dealing with responses from the network request is handled. ViewModels should interface this layer to get updated data as necessary.
- Coordinator is responsible for handling application flow, decides when and where to go based on events from ViewModel (trigers routing functions).

`View` <- `ViewController` <- bindings -> (`ViewModel` -> `Model`) <- trigers -> `Coordinator`

