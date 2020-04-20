# Clean Master Detail iOS 

Master Detail iOS Application using swift 5 and [clean swift](https://clean-swift.com).

Functionalities include:
* Refresh from service
* Display all/favorites
* Delete All
* Display as not viewed/favorite
* Toggle favorite
* Swipe to remove
* REST Client
* Unit Tests

## Run instructions
Donwload manually, or clone repository:

 ```bash
git clone https://github.com/huffmann/clean-swift-vip && cd clean-swift-vip
```
 
 In repository folder, Install Alamofire via [cocoapods](https://cocoapods.org) command:

```bash
pod install
```

And finally to open project, open .xcworkspace file 


## Architecture details

[Clean swift](https://clean-swift.com) is an Architectural approach that ensures code is structured in a clear and easy to undertand manner (see [screaming architecture](https://blog.cleancoder.com/uncle-bob/2011/09/30/Screaming-Architecture.html)), and it also enforces SOLID principles.  The main objects of this design are:  View, Interactor, Presenter, Entity, Router and UseCase. In a Clean design, Data flows one way in a __V-I-P__ Cycle: 

View -> Interactor -> Presenter -> View

The __View__ informs the Interactor of an event and binds data if required. (ie: did press search button)

The __Interactor__ uses the received data to gather the necessary data via UseCase.

__UseCases__ are where the _business logic_ resides. Here is where the app call services, loads from repositories, etc. 

After getting result from useCase, Interactor informs presenter about result with the gathered data. 

__Presenter__ formats this data to a ViewModel and sends it to __View__ to consume. 

__ViewModel__

This Object type, has the dataModel as well as the required properties for correct display, ie: icons, toggles, etc. 

## Delegate Pattern 

Protocol used for communication between view controllers: inform of events, send data. 

labeled _weak_ to avoid retain cycles. 

## Web Services
All REST API service calls are managed via [Alamofire](https://github.com/Alamofire/Alamofire), which is a robust, community driven, HTTP networking library written in Swift.

For service response _data parsing_, I used swift's [Decodable](https://developer.apple.com/documentation/swift/decodable) protocol which is neatly integrated into Alamofire via __responseDecodable__ 

The web service class binds a __Generic__ Decodable class which will be returned _async_ via completion handler. 

## Future Enhancements 
I will work on moving user interface to SwiftUI and Combine instead of Interface builder. And from there...

                         .-.
                        ( (
                         `-'



                    .   ,- To the Moon!
                   .'.
                   |o|
                  .'o'.
                  |.-.|
                  '   '
                   ( )
                    )
                   ( )

