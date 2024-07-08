# step_sub

An app for subscriptions

## Getting Started

Your progress in the step form will be saved for each platform respectively, so if you restart the app, you don't have to worry, pick off where you left off.

To run the app on different platforms, please follow the instructions below:
    
In your terminal, navigate to your folder with the step_sub app and write the following commands in said order to start them on desired platforms.


## Windows:
    
flutter run -d windows

## Web:
to see the available devices for web, in the terminal write: flutter devices
to run on a specific browser (i.e. Chrome) on localhost run the following command: flutter run -d chrome

## Mobile iOS/Android
iOS:
to see the available devices for iOS (only on MacOS), in the terminal write: flutter devices
to run on a specific iOS Simulator (i.e. iPhone 15 Pro) add the ID at the end of the command (you will see the ID in list of devices from the step before) and run the following command: flutter run -d 2C04C720-70B8-4D30-A718-B66E7B87421E
for any other device from the list run: flutter run -d <id_device>

Android:
to see the available emulators for Android, in the terminal write: flutter emulators
to launch a specific emulator (i.e. Nexus_5_API_30), add the ID at the end of the command (you will see the ID in list of emulator from the step before) and run the following command: flutter emulators --launch Nexus_5_API_30
for any other device from the list run: flutter emulators --launch <id_device>
after the emulator has been launched, write the following command to start the app: flutter run

## Run app on AndroidStudio

select the device (iOS/Android/Web/Desktop) in the device dropdown menu and run/debug or select a device and in the terminal run: flutter run
