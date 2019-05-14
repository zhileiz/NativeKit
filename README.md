# NativeKit
An iOS Demo for WKWebView supported mini-programs


## Test-run Instructons
0. **Prerequisites: npm and xcode 10**
1. `cd` into ZZeact folder first, and run `npm start`
  * This will boot up the demo JS app on `localhost:8081`
2. open `NativeKit.xcworkspace`, and hit "Run"
3. On the TableView you see, pull down to reveal the mini-program drawer
4. Select the first icon, and you will see the content of `localhost:8081`.
  * You can now verify the capabilities

## Capabilities
1. JS app UI loaded in the screen
2. Message passing from JS app to native app
  * Hit like button of the JS app, you will see that the native app navigation title change.
  * Hit close button of the JS app, you will be able to navigate back in the native app.
3. Message passing from native app to JS app
  * When like button of the JS app is hit, it triggers the native app to send a message to the JS app and change the document content.

## Screenshot
![Demo](https://github.com/zhileiz/NativeKit/blob/master/demo.gif =400x)