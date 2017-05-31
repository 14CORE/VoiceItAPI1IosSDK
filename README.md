<img src="Graphics/VoiceItHeaderImage.png" width="100%" style="width:100%">

[![Version](https://img.shields.io/cocoapods/v/VoiceItApi2IosSDK.svg?style=flat)](http://cocoapods.org/pods/VoiceItAPI1IosSDK)
[![License](https://img.shields.io/cocoapods/l/VoiceItApi2IosSDK.svg?style=flat)](http://cocoapods.org/pods/VoiceItAPI1IosSDK)
[![Platform](https://img.shields.io/cocoapods/p/VoiceItApi2IosSDK.svg?style=flat)](http://cocoapods.org/pods/VoiceItAPI1IosSDK)
<!-- [![Build Status](https://travis-ci.org/voiceittech/VoiceItApi2IosSDK.svg?branch=master)](https://travis-ci.org/voiceittech/VoiceItApi2IosSDK) -->

## VoiceIt API 1.0 iOS SDK

A library that gives you access to the VoiceIt's API 1.0 enabling you to add Voice Authentication to your iOS app.

* [Getting Started](#getting-started)
* [Installation](#installation)
* [API Calls](#api-calls)
  * [Initialization](#initialization)
  * [User API Calls](#user-api-calls)
      * [Create User](#create-user)
      * [Get User](#get-user)
      * [Delete User](#delete-user)      
  * [Enrollment API Calls](#enrollment-api-calls)
      * [Get Enrollments](#get-enrollments)
      * [Delete Enrollment](#delete-enrollment)
      * [Create Enrollment](#create-enrollment)
  * [Authentication API Calls](#authentication-api-calls)
      * [Authentication](#authentication)

## Getting Started

Get a Developer Account at <a href="https://siv.voiceprintportal.com/getDeveloperIDTile.jsp" target="_blank">VoiceIt</a>. Also review the HTTP Documentation at <a href="https://siv.voiceprintportal.com/apidocs.jsp" target="_blank">VoiceIt api docs</a>. All the documentation shows code snippets in both Swift 3 and Objective-C.

## Installation

VoiceItAPI1IosSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VoiceItAPI1IosSDK"
```

and then run pod install in your terminal

```bash
pod install
```

## API Calls

### Initialization

#### *Swift*

First import *VoiceItAPI1IosSDK* into your Swift file then initialize a reference to the SDK inside a ViewController

```swift
import VoiceItAPI1IosSDK

class ViewController: UIViewController {
    var myVoiceIt:VoiceItAPIOne?

    override func viewDidLoad() {
        super.viewDidLoad()
        myVoiceIt  = VoiceItAPIOne("DEVELOPER_ID_HERE")
    }
}
```
#### *Objective-C*

First import *VoiceItAPIOne.h* into your Objective-C file, then initialize a reference to the SDK inside a ViewController

```objc
#import "ViewController.h"
#import "VoiceItAPIOne.h"

@interface ViewController ()
    @property VoiceItAPIOne * myVoiceIt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myVoiceIt = [[VoiceItAPIOne alloc] init: "DEVELOPER_ID_HERE"];
}
```

### User API Calls

#### Create User

Create a new user with the provided userId(alphanumeric string between 5 -36 characters)
##### *Swift*
```swift
myVoiceIt?.createUser("USER_ID_HERE", password:"PASSWORD_HERE", {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```
##### *Objective-C*
```objc
[_myVoiceIt createUser:@"USER_ID_HERE" password:@"PASSWORD_HERE" callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
}];
```

#### Get User

Check whether a user exists for the given userId
##### *Swift*
```swift
myVoiceIt?.getUser("USER_ID_HERE", password:"PASSWORD_HERE", callback: {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```
##### *Objective-C*
```objc
[_myVoiceIt getUser:@"USER_ID_HERE" password:@"PASSWORD_HERE" callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
}];
```

#### Delete User

Delete user with given userId
##### *Swift*
```swift
myVoiceIt?.deleteUser("USER_ID_HERE", password:"PASSWORD_HERE"password:"PASSWORD_HERE", , callback: {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```
##### *Objective-C*
```objc
[_myVoiceIt deleteUser:@"USER_ID_HERE" password:@"PASSWORD_HERE" callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
}];
```


### Enrollment API Calls

#### Get Enrollments

Gets enrollments for user with given userId
##### *Swift*
```swift
myVoiceIt?.getEnrollments("USER_ID_HERE", password:"PASSWORD_HERE", callback: {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```

##### *Objective-C*
```objc
[_myVoiceIt getEnrollments:@"USER_ID_HERE" password:@"PASSWORD_HERE" callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
}];
```

#### Delete Enrollment

Delete enrollment for user with given userId and enrollmentId(integer)
##### *Swift*
```swift
myVoiceIt?.deleteEnrollment("USER_ID_HERE", password:"PASSWORD_HERE", enrollmentId: "ENROLLMENT_ID_HERE", callback: {
    jsonResponse in
})
```

##### *Objective-C*
```objc
[_myVoiceIt deleteEnrollment:@"USER_ID_HERE" password:@"PASSWORD_HERE" enrollmentId:@"ENROLLMENT_ID_HERE" callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
}];
```

#### Create Enrollment

Create audio enrollment for user with given userId and contentLanguage('en-US','es-ES' etc.). Note: Immediately upon calling this method it records the user saying their VoicePrint phrase for 5 seconds calling the recordingFinished callback first, then it sends the recording to be added as an enrollment and returns the result in the callback
##### *Swift*
```swift
myVoiceIt?.createEnrollment("USER_ID_HERE", password:"PASSWORD_HERE", contentLanguage: "CONTENT_LANGUAGE_HERE", recordingFinished: {
    print("Audio Enrollment Recording Finished, now waiting for API Call to respond")
}, callback: {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```

##### *Objective-C*
```objc
[_myVoiceIt createEnrollment:@"USER_ID_HERE" password:@"PASSWORD_HERE" contentLanguage: @"CONTENT_LANGUAGE_HERE" recordingFinished:^(void){
    NSLog(@"Audio Enrollment Recording Finished, now waiting for API Call to respond");
} callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
} ];
```

#### Authentication

Authenticate user with the given userId and contentLanguage('en-US','es-ES' etc.). Note: Immediately upon calling this method it records the user saying their VoicePrint phrase for 5 seconds calling the recordingFinished callback first, then it sends the recording to be verified and returns the resulting confidence in the callback
##### *Swift*
```swift
myVoiceIt?.authentication("USER_ID_HERE", password:"PASSWORD_HERE", contentLanguage: "CONTENT_LANGUAGE_HERE", recordingFinished: {
    print("Authentication Recording Finished, now waiting for API Call to respond")
}, callback: {
    jsonResponse in
    print("JSON RESPONSE: \(jsonResponse!)")
})
```

##### *Objective-C*
```objc
[_myVoiceIt authentication:@"USER_ID_HERE" password:@"PASSWORD_HERE" contentLanguage:@"CONTENT_LANGUAGE_HERE" recordingFinished:^(void){
    NSLog(@"Authentication Recording Finished, now waiting for API Call to respond");
} callback:^(NSString * jsonResponse){
    NSLog(@"JSONResponse: %@", jsonResponse);
} ];
```

## Author

armaanbindra, armaan.bindra@voiceit-tech.com

## License

VoiceItAPI1IosSDK is available under the MIT license. See the LICENSE file for more info.
