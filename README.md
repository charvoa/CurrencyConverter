#Revolut - Project

##Libraries 

I chose to use CocoaPods because I use this dependency manager everyday and I wanted to keep it simple as I did not want to add many dependencies. 

1) Alamofire 

I chose to use Alamofire because I needed to setup a quick APIClient in order to make one request, a complete HTTP Client home made would have been overkill. So I kept it simple for that part. 

2) Reusable

This pod helps in the management of UICollectionViews and other Nib-based views, as I wanted to use a collectionView for its flexibility and its ease of use I know I wanted to use this library. I’m using it in every project and it saves a lot of time and a lot of lines. 

3) Swiftlint

I wanted to have a warning-free project, and I know that it’s very important to keep a consistent code style within a team. That’s why I used Swiftlint, without removing any rules or adjusting them to my convenience. 

_________

##Architecture 

I used a simple MVVM architecture in order to display the converter. I also include ‘micro-services’, one service that would handle the construction of the currencies (via the APIClient built on top of Alamofire), and one service that would handle the conversion of the currencies. Another service is also used in order to schedule the refresh of rates (every seconds a refresh is triggered via this service ‘DispatchService’) 

_________

##Unit Tests

I constructed simple Unit tests that tests my model, my view models and my APIClient via a mocked APIClient with a mocked result. 

_________

##Possible improvements 

In the time frame I was given and with my day job I was not able to make the perfect app, although I respected the given exercise in its entirety and added some designs part like the icon or the LaunchScreen in order to make it feel like a real iOS app. 

The biggest point that could be improved is the display of the flags, I was not able to find something perfect so some flags may appear a bit clipped. But with more time, or the help of a designer we could achieve something like in the real Revolut app with perfectly displayed round flags. 