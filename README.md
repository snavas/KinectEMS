# KinectEMS

## R
Contains all the code to visualise and analise the kinect skelleton data in R.
- function drawCanvas(): draw an empty canvas with the IVE 
** alpha: rotation in degrees of the IVE
- function printSkeleton(): draw a skeleton given a kinect skeleton data as input
* string file: path to the kinect data file
* string color: color
* bool right: true if the person is right handed 
- function printMeanSkeleton(): prints an average skeleton given multiple skeletons
* string[] files: path to the kinect data files
* string output: path to where the average skeleton data file will be saved

## BodyBasics-WPF
C# app. 
 - Recieve and visualise skeleton data from the Kinect stream (Physical kinect or Kinect Studio)
 - Visualise skeleton data saved in a file
 - Send BLE or UPD messages with EMS information
 
 ## Python BLE-UDP Bridge
 Start an UDP server (localhost) and forward all the recieved messages to the EMS BLE device.
