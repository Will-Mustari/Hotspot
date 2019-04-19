# Hotspot
Find and rank the hottest clubs and bars in your area! Hotspot coming soon to iOS.

# Running application
Must be built in xCode onto a simulator or directly onto iOS device. Apple does not allow for executables to be made without adding it to the app store or through a crowd sourcing program

Cloning the project will not always lead to the best result due to Cocoapods being finicky. For best results, follow these steps:
1. Clone project in order to get a clean copy
2. Open terminal and navigate to project directory
3. %pod install
4. %pod update
5. The project should now run smoothly. If not, continue reading. . .
6. open pod file and comment out some lines:
    #pod 'Firebase/Core'
    #pod 'Firebase/Auth'
    #pod 'Firebase/Firestore'
7. Do steps 3 and 4 again. Then uncomment and do steps 3 and 4 a third time.
