# KinectEMS

## R
<img src="https://i.imgur.com/jYqMpbd.png" width="600">

Contains all the code to visualise and analise the kinect skelleton data in R.
* function drawCanvas(): draw an empty canvas with the IVE 
  * alpha: rotation in degrees of the IVE
* function printSkeleton(): draw a skeleton given a kinect skeleton data as input
  * string file: path to the kinect data file (generated with [Kinect2Toolbox](https://github.com/xiaozhuchacha/Kinect2Toolbox)) ([example](https://github.com/snavas/KinectEMS/blob/master/R/data/P17S1Q1.txt))
  * string color: color
  * bool right: true if the person is right handed 
* function printMeanSkeleton(): prints an average skeleton given multiple skeletons
  * string[] files: path to the kinect data files
  * string output: path to where the average skeleton data file will be saved ([example](https://github.com/snavas/KinectEMS/blob/master/R/output/test.txt))

## BodyBasics-WPF
<img src="https://i.imgur.com/ipETGWA.png" width="400">

C# app. 
 - Recieve and visualise skeleton data from the Kinect stream (Physical kinect or Kinect Studio)
 - Visualise skeleton data saved in a file
 - Send BLE or UPD messages with EMS information
 
 ## Python BLE-UDP Bridge
 Start an UDP server (localhost) and forward all the recieved messages to the EMS BLE device.
 
 ## Useful:
 * Kinect JointType Enumeration: https://docs.microsoft.com/en-us/previous-versions/windows/kinect/dn758663(v=ieb.10)
 * CameraSpacePoint Structure: https://docs.microsoft.com/en-us/previous-versions/windows/kinect/dn772836(v%3dieb.10)
 
## ACKNOWLEDGMENTS
BodyBasics-WPF is a modified version of the sample code provide by Microsoft in the Kinect 2.0 SDK Browser.

EMSModule is a fork of the Let Your Body Move ToolKit by Max Pfeiffer https://bitbucket.org/MaxPfeiffer/letyourbodymove/wiki/Home

This project has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No 676063

## LICENSE
This work is unter a MIT License Copyright (c) 2018 Samuel Navas Medrano as stated in LICENSE
