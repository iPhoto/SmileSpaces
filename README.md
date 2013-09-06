SmileSpaces Platform
===========
![image](http://img27.imageshack.us/img27/8845/bukb.png)

SmileSpaces is a interesting platform to find the best happy areas in your city according to many factors, curltural, healthy, users... Thanks to our advanced algorith "Felix" and exhaustive data analysis. Moreover you'll have a full API REST for implementing your own solution with our data. In our repo you'll find iOS and Android applications to have an idea of what you can do :)

:smile: Share happiness! :smile:

# Web Server Backend
We've developed our platform using a know micro-framework web base on Python, **Flask**. The reason why chose it is that it's very fast, easy to implement and powerful.
Although Flask has a Web Server for testing it's not recommended using it out of developing, that's the reason why we've complemented it with NGINX+GUNICORN. SQLite database is the chosen solution for our initial project.

If you want to test it you don't need this configuration. Only download the project and executing:
```python
python runSmile.py
```
#### Requiremens
- Python 2.7
- Flask
- Flask-SQLAlchemy
- Flask-Admin

( You can install all of them using PIP command )

### API Requests
File views.py includes all web paths that our API is able to process. Here you have a list of them:
- **/api/1/City**: To get a list of all the cities ( POST, PUT, GET, DELETE )
- **/api/1/City/<cityID>**: To get all zones of the city ( GET, POST, PUT, DELETE )
- **/api/1/Data/<cellID>**: To get detailed information of a cell ( POST, PUT, GET, DELETE )

*Note: Some REST request may not be implemented. We're working on these features*

### Admin view
Thanks to Flask-Admin you'll have access to an Admin panel and take control over the backend data. The URL to access it is: http://127.0.0.1:5000/admin


# iOS Application
iOS application as a location mobile service has a main View with the map of the city ( depending on the version of the App ). In this view you'll be able to have a global sightseing of every zone with a smile/color indicating the happiness of zone. From this view you'll be able to open more details of the zone ( touching in the zone pin ) or share your feeling in the place where you are.

![image](http://img22.imageshack.us/img22/6086/j2so.png)

#### Implemented features
- **Hapiness MapView**: Browse happniness around you in your city thanks to this mapView. You'll be able to center it in your location and zoom thanks to pinch gesture. Markers wi'll be expanded like cells!. If you need more details push over one of this.
- **Add feeling to your city database**: Choose your feeling in your current place selecting a color in the gradient selector. We'll calculate your feeling from your color selection. More over ( implemented in the future ) if you connect your social accounts we'll do a semantic analysis to get more information about your current context feeling . Amazing, isn't it? Felix cat we'll do magic with all this data. Photos will be able to be attached in a next release.
- **Zone detail view**: Get more detailed information about any area. Using our chart you'll take a global idea of it according to five parameters Felix has calculated. If you are looking more information, don't worry, scroll down and discover each detailed one in a percentage way.

### Custom controls
Controls that we've created to get better UX in the app:
- **gradientProgress**: Animated gradient progress to add in tableviewCells. It includes a method to reset the progress and to animate it from 0 to a given percentage. 

![image](http://img27.imageshack.us/img27/9710/7zlw.png)

### External Controls
We would like to thanks all these control that have helped us to get faster in our development and add interesting features to improve our app. And thanks to CocoaPods too for its 3rd party libraries installation helper. 
Here they are:
```
pod 'AFNetworking', '~> 1.3.2'
pod 'SVProgressHUD'
pod 'QuickDialog'
pod 'ADClusterMapView'
pod 'NullSafe'
pod 'UIKitCategoryAdditions', :git => 'https://github.com/pepibumur/UIKitCategoryAddi$
pod 'RPRadarChart', :git => 'https://github.com/pepibumur/RPRadarChart.git'
pod 'PPiAwesomeButton', :git => 'https://github.com/pepibumur/PPiAwesomeButton.git'
pod 'PPiFlatSegmentedControl', :git => 'https://github.com/pepibumur/PPiFlatSegmented$
pod 'FlatUIKit'
pod 'XMLDictionary'
pod 'DKLiveBlur', :git => 'https://github.com/pepibumur/DKLiveBlur.git'
pod 'APParallaxHeader'
```

### Test on your own
1. Clone the repository and open iOS Folder
2. Once in this directory install CocoaPods ( you'll find more information [here](http://cocoapods.org/) about how to do it )
3. After, execute from terminal `pod install` ( be sure you are in the iOS project folder in terminal )
4. If everything goes well you should open the project **from .xcworkspace** file. 

### Some Screenshots
![image](http://imageshack.us/a/img546/4770/txlu.png)
![image](http://imageshack.us/a/img841/6818/0lso.png)
![image](http://imageshack.us/a/img7/3721/cfyh.png)
![image](http://ppinera.es/iOSData/SmileSpaces/smile.gif)

### Future guidelines
- Introduce polygon layouts in mapview to bound more detailed areas
- Add feeling connection with Server ( including add photo feature in maps )
- Information Screen with some settings.
- Active notifications
- Gamification in users profiles 

## Android Backend


## Source
We've found all these London Feeds to our dababase Backend. The solution is global so in the future is required to adapt this platform to another city we only have to link our system with the new city sources.
Sources from London:
- Transport for London: http://www.tfl.gov.uk
- LondonAir API


## Team
![image](http://imageshack.us/a/img22/4400/69bw.png)
![image](http://img545.imageshack.us/img545/4845/7ifz.png)
![image](http://imageshack.us/a/img546/7083/adv1.png)
![image](http://img707.imageshack.us/img707/5892/0m6i.png)

- **Isaac Roldán**: Web/Backend developer and Felix's father
- **Fran Díaz**: GodFather of Felix and 
- **LLorens Delgado**: Android Developer
- **Pedro Piñera**: iOS Developer
