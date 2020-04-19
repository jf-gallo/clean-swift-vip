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

## Run instructions
Donwload manually, or clone repository to you machine:

 ```bash
git clone https://github.com/huffmann/clean-swift-vip
```
 
 In repository folder, Install Alamofire via [cocoapods](https://cocoapods.org) command:

```bash
pod install
```

## Architecture details

[Clean swift](https://clean-swift.com) is a VIPER Architecture  (View, Interactor, Presenter, Entity, Router) where Data flows one way in in a __V-I-P__ Cycle: 

View -> Interactor -> Presenter -> View

The __View__ informs the Interactor about an event. (ie: did press button)

The __Interactor__ uses the received data to gather the necessary data via UseCase.

__UseCases__ are where the _business logic_ resides. Here is where the app call services, loads from repositories, etc. 

After getting result from useCase, Interactor informs presenter about result with the gathered data. 

__Presenter__ formats this data to a ViewModel and sends it to __View__ to consume. 

__ViewModel__

This Object type, has the dataModel as well as the required properties for correct display, ie: icons, toggles, etc. 

## Delegate Pattern 

Used for communication between view controllers: inform of events, send data. 

labeled _weak_ to avoid retain cycles. 

## Web Services
All REST API service calls are managed via [Alamofire](https://github.com/Alamofire/Alamofire), which is a robust, community driven, HTTP networking library written in Swift.

For service response _data parsing_, I used swift's [Decodable](https://developer.apple.com/documentation/swift/decodable) which is nicely integrated into Alamofire via __responseDecodable__ 

## Future Enhancements 
I will work on moving user interface to SwiftUI and Combine instead of Interface builder. But the viper remains as is. 

                         __      
           ---_ ...... _/_ -    
          /  .      ./ .'*\ \    
          : '         /__-'   \. 
         /                      )
       _/                  >   .' 
     /   .   .       _.-" /  .'   
     \           __/"     /.'/|   
       \ '--  .-" /     //' |\|  
        \|  \ | /     //_ _ |/|
         `.  \:     //|_ _ _|\|
         | \/.    //  | _ _ |/| 
          \_ | \/ /    \ _ _ \\\ 
              \__/      \ _ _ \|\

