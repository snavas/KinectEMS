//------------------------------------------------------------------------------
// <copyright file="MainWindow.xaml.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

namespace Microsoft.Samples.Kinect.BodyBasics
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Net.Sockets;
    using System.Text;
    using System.Windows;
    using System.Windows.Input;
    using System.Windows.Media;
    using System.Windows.Media.Imaging;
    using Microsoft.Kinect;
    using Windows.Devices.Bluetooth;
    using Windows.Devices.Enumeration;
    using System.IO.Ports;

    /// <summary>
    /// Interaction logic for MainWindow
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        /// <summary>
        /// Radius of drawn hand circles
        /// </summary>
        private const double HandSize = 30;

        /// <summary>
        /// Thickness of drawn joint lines
        /// </summary>
        private const double JointThickness = 3;

        /// <summary>
        /// Thickness of clip edge rectangles
        /// </summary>
        private const double ClipBoundsThickness = 10;

        /// <summary>
        /// Constant for clamping Z values of camera space points from being negative
        /// </summary>
        private const float InferredZPositionClamp = 0.1f;

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as closed
        /// </summary>
        private readonly Brush handClosedBrush = new SolidColorBrush(Color.FromArgb(128, 255, 0, 0));

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as opened
        /// </summary>
        private readonly Brush handOpenBrush = new SolidColorBrush(Color.FromArgb(128, 0, 255, 0));

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as in lasso (pointer) position
        /// </summary>
        private readonly Brush handLassoBrush = new SolidColorBrush(Color.FromArgb(128, 0, 0, 255));

        /// <summary>
        /// Brush used for drawing joints that are currently tracked
        /// </summary>
        private readonly Brush trackedJointBrush = new SolidColorBrush(Color.FromArgb(255, 68, 192, 68));

        /// <summary>
        /// Brush used for drawing joints that are currently tracked
        /// </summary>
        private readonly Brush ArchetypeBrush = new SolidColorBrush(Color.FromArgb(255, 255, 192, 203));
        //private readonly Brush ArchetypeBrush = new SolidColorBrush(Color.FromArgb(255, 68, 192, 68));


        /// <summary>
        /// Brush used for drawing joints that are currently inferred
        /// </summary>        
        private readonly Pen ArchetypePen = new Pen(Brushes.Pink, 3);

        /// <summary>
        /// Brush used for drawing joints that are currently inferred
        /// </summary>        
        private readonly Brush inferredJointBrush = Brushes.Yellow;

        /// <summary>
        /// Pen used for drawing bones that are currently inferred
        /// </summary>        
        private readonly Pen inferredBonePen = new Pen(Brushes.Gray, 1);

        /// <summary>
        /// Drawing group for body rendering output
        /// </summary>
        private DrawingGroup drawingGroup;

        /// <summary>
        /// Drawing image that we will display
        /// </summary>
        private DrawingImage imageSource;

        /// <summary>
        /// Active Kinect sensor
        /// </summary>
        private KinectSensor kinectSensor = null;

        /// <summary>
        /// Coordinate mapper to map one type of point to another
        /// </summary>
        private CoordinateMapper coordinateMapper = null;

        /// <summary>
        /// Reader for body frames
        /// </summary>
        private BodyFrameReader bodyFrameReader = null;

        /// <summary>
        /// Array for the bodies
        /// </summary>
        private Body[] bodies = null;

        /// <summary>
        /// definition of bones
        /// </summary>
        private List<Tuple<JointType, JointType>> bones;

        /// <summary>
        /// Width of display (depth space)
        /// </summary>
        private int displayWidth;

        /// <summary>
        /// Height of display (depth space)
        /// </summary>
        private int displayHeight;

        /// <summary>
        /// List of colors for each body tracked
        /// </summary>
        private List<Pen> bodyColors;

        /// <summary>
        /// Current status text to display
        /// </summary>
        private string statusText = null;
        
        /// <summary>
        /// Initializes a new instance of the MainWindow class.
        /// </summary>
        public MainWindow()
        {
            // one sensor is currently supported
            this.kinectSensor = KinectSensor.GetDefault();

            // get the coordinate mapper
            this.coordinateMapper = this.kinectSensor.CoordinateMapper;

            // get the depth (display) extents
            FrameDescription frameDescription = this.kinectSensor.DepthFrameSource.FrameDescription;

            // get size of joint space
            this.displayWidth = frameDescription.Width;
            this.displayHeight = frameDescription.Height;

            // open the reader for the body frames
            this.bodyFrameReader = this.kinectSensor.BodyFrameSource.OpenReader();

            // a bone defined as a line between two joints
            this.bones = new List<Tuple<JointType, JointType>>();

            // Torso
            this.bones.Add(new Tuple<JointType, JointType>(JointType.Head, JointType.Neck));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.Neck, JointType.SpineShoulder));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.SpineMid));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineMid, JointType.SpineBase));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.ShoulderRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.ShoulderLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineBase, JointType.HipRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineBase, JointType.HipLeft));

            // Right Arm
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ShoulderRight, JointType.ElbowRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ElbowRight, JointType.WristRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristRight, JointType.HandRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HandRight, JointType.HandTipRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristRight, JointType.ThumbRight));

            // Left Arm
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ShoulderLeft, JointType.ElbowLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ElbowLeft, JointType.WristLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristLeft, JointType.HandLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HandLeft, JointType.HandTipLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristLeft, JointType.ThumbLeft));

            // Right Leg
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HipRight, JointType.KneeRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.KneeRight, JointType.AnkleRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.AnkleRight, JointType.FootRight));

            // Left Leg
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HipLeft, JointType.KneeLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.KneeLeft, JointType.AnkleLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.AnkleLeft, JointType.FootLeft));

            // populate body colors, one for each BodyIndex
            this.bodyColors = new List<Pen>();

            this.bodyColors.Add(new Pen(Brushes.Red, 6));
            this.bodyColors.Add(new Pen(Brushes.Orange, 6));
            this.bodyColors.Add(new Pen(Brushes.Green, 6));
            this.bodyColors.Add(new Pen(Brushes.Blue, 6));
            this.bodyColors.Add(new Pen(Brushes.Indigo, 6));
            this.bodyColors.Add(new Pen(Brushes.Violet, 6));

            // set IsAvailableChanged event notifier
            this.kinectSensor.IsAvailableChanged += this.Sensor_IsAvailableChanged;

            // open the sensor
            this.kinectSensor.Open();

            // set the status text
            this.StatusText = this.kinectSensor.IsAvailable ? Properties.Resources.RunningStatusText
                                                            : Properties.Resources.NoSensorStatusText;

            // Create the drawing group we'll use for drawing
            this.drawingGroup = new DrawingGroup();

            // Create an image source that we can use in our image control
            this.imageSource = new DrawingImage(this.drawingGroup);

            // use the window object as the view model in this simple example
            this.DataContext = this;

            // initialize the components (controls) of the window
            this.InitializeComponent();
        }

        /////////////////////////////////////////////////////////////////////////////////
        /// EMS PART
        /////////////////////////////////////////////////////////////////////////////////

        /*
        EventManager.RegisterClassHandler(typeof(Window), Keyboard.KeyUpEvent,new KeyEventHandler(keyUp), true);

        private void keyUp(object sender, KeyEventArgs e){
            if (e.Key == Key.OemComma) MessageBox.Show("YAY!!!");
        }
        */

            /*
        // Boolean flag used to determine when a character other than a number is entered.
        private bool nonNumberEntered = false;

        // Handle the KeyDown event to determine the type of character entered into the control.
        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            Console.WriteLine("Something pressed");
            // Initialize the flag to false.
            nonNumberEntered = false;

            if (e.Key == Key.D1) {
                Console.WriteLine("1 Pressed");
            } else if (e.Key == Key.D2) {
                Console.WriteLine("2 Pressed");
            } else if (e.Key == Key.D3) {
                Console.WriteLine("3 Pressed");
            } else if (e.Key == Key.D4) {
                Console.WriteLine("4 Pressed");
            } else {
                nonNumberEntered = true;
            }

            /*
            // Determine whether the keystroke is a number from the top of the keyboard.
            if (e.KeyCode < Keys.D0 || e.KeyCode > Keys.D9)
            {
                // Determine whether the keystroke is a number from the keypad.
                if (e.KeyCode < Keys.NumPad0 || e.KeyCode > Keys.NumPad9)
                {
                    // Determine whether the keystroke is a backspace.
                    if (e.KeyCode != Keys.Back)
                    {
                        // A non-numerical keystroke was pressed.
                        // Set the flag to true and evaluate in KeyPress event.
                        nonNumberEntered = true;
                    }
                }
            } */
        //}

            /*
        // This event occurs after the KeyDown event and can be used to prevent
        // characters from entering the control.
        private void textBox1_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            // Check for the flag being set in the KeyDown event.
            if (nonNumberEntered == true)
            {
                // Stop the character from being entered into the control since it is non-numerical.
                e.Handled = true;
            }
        }*/

        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// INotifyPropertyChangedPropertyChanged event to allow window controls to bind to changeable data
        /// </summary>
        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Gets the bitmap to display
        /// </summary>
        public ImageSource ImageSource
        {
            get
            {
                return this.imageSource;
            }
        }

        /// <summary>
        /// Gets or sets the current status text to display
        /// </summary>
        public string StatusText
        {
            get
            {
                return this.statusText;
            }

            set
            {
                if (this.statusText != value)
                {
                    this.statusText = value;

                    // notify any bound elements that the text has changed
                    if (this.PropertyChanged != null)
                    {
                        this.PropertyChanged(this, new PropertyChangedEventArgs("StatusText"));
                    }
                }
            }
        }

        /// <summary>
        /// Execute start up tasks
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            if (this.bodyFrameReader != null)
            {
                this.bodyFrameReader.FrameArrived += this.Reader_FrameArrived;
            }
        }

        /// <summary>
        /// Execute shutdown tasks
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void MainWindow_Closing(object sender, CancelEventArgs e)
        {
            if (this.bodyFrameReader != null)
            {
                // BodyFrameReader is IDisposable
                this.bodyFrameReader.Dispose();
                this.bodyFrameReader = null;
            }

            if (this.kinectSensor != null)
            {
                this.kinectSensor.Close();
                this.kinectSensor = null;
            }
        }

        /// <summary>
        /// Handles the body frame data arriving from the sensor
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Reader_FrameArrived(object sender, BodyFrameArrivedEventArgs e)
        {
            bool dataReceived = false;

            using (BodyFrame bodyFrame = e.FrameReference.AcquireFrame())
            {
                if (bodyFrame != null)
                {
                    if (this.bodies == null)
                    {
                        this.bodies = new Body[bodyFrame.BodyCount];
                    }

                    // The first time GetAndRefreshBodyData is called, Kinect will allocate each Body in the array.
                    // As long as those body objects are not disposed and not set to null in the array,
                    // those body objects will be re-used.
                    bodyFrame.GetAndRefreshBodyData(this.bodies);
                    dataReceived = true;
                }
            }

            if (dataReceived)
            {
                using (DrawingContext dc = this.drawingGroup.Open())
                {
                    // Draw a transparent background to set the render size
                    dc.DrawRectangle(Brushes.Black, null, new Rect(0.0, 0.0, this.displayWidth, this.displayHeight));

                    int penIndex = 0;
                    foreach (Body body in this.bodies)
                    {
                        Pen drawPen = this.bodyColors[penIndex++];

                        if (body.IsTracked)
                        {
                            this.DrawClippedEdges(body, dc);

                            IReadOnlyDictionary<JointType, Joint> joints = body.Joints;

                            // convert the joint points to depth (display) space
                            Dictionary<JointType, Point> jointPoints = new Dictionary<JointType, Point>();

                            foreach (JointType jointType in joints.Keys)
                            {
                                // sometimes the depth(Z) of an inferred joint may show as negative
                                // clamp down to 0.1f to prevent coordinatemapper from returning (-Infinity, -Infinity)
                                CameraSpacePoint position = joints[jointType].Position;
                                if (position.Z < 0)
                                {
                                    position.Z = InferredZPositionClamp;
                                }

                                DepthSpacePoint depthSpacePoint = this.coordinateMapper.MapCameraPointToDepthSpace(position);
                                jointPoints[jointType] = new Point(depthSpacePoint.X, depthSpacePoint.Y);
                            }

                            this.DrawBody(joints, jointPoints, dc, drawPen);

                            this.DrawHand(body.HandLeftState, jointPoints[JointType.HandLeft], dc);
                            this.DrawHand(body.HandRightState, jointPoints[JointType.HandRight], dc);
                        }
                    }

                    // prevent drawing outside of our render area
                    this.drawingGroup.ClipGeometry = new RectangleGeometry(new Rect(0.0, 0.0, this.displayWidth, this.displayHeight));
                }
            }
        }

        /// <summary>
        /// Draws a body
        /// </summary>
        /// <param name="joints">joints to draw</param>
        /// <param name="jointPoints">translated positions of joints to draw</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        /// <param name="drawingPen">specifies color to draw a specific body</param>
        private void DrawBody(IReadOnlyDictionary<JointType, Joint> joints, IDictionary<JointType, Point> jointPoints, DrawingContext drawingContext, Pen drawingPen)
        {
            // Draw the bones
            foreach (var bone in this.bones)
            {
                this.DrawBone(joints, jointPoints, bone.Item1, bone.Item2, drawingContext, drawingPen);
            }

            // Draw the joints
            foreach (JointType jointType in joints.Keys)
            {
                Brush drawBrush = null;

                TrackingState trackingState = joints[jointType].TrackingState;

                if (trackingState == TrackingState.Tracked)
                {
                    drawBrush = this.trackedJointBrush;
                }
                else if (trackingState == TrackingState.Inferred)
                {
                    drawBrush = this.inferredJointBrush;
                }

                if (drawBrush != null)
                {
                    drawingContext.DrawEllipse(drawBrush, null, jointPoints[jointType], JointThickness, JointThickness);
                }
            }

            // Draw the Archetype
            DrawArchetype(drawingContext, drawingPen);
        }

        private void DrawArchetype(DrawingContext drawingContext, Pen drawingPen)
        {
            var joints = new List<Point>();

            string[] lines = System.IO.File.ReadAllLines(@"C:\Users\s_nava02\Dropbox\data\ArchetypeS3Q7.txt");
            lines = lines.Skip(1).ToArray();
            //System.Console.WriteLine("Contents of WriteLines2.txt = ");
            foreach (string line in lines)
            {
                // Use a tab to indent each line of the file.
                // Console.WriteLine("\t" + line);
                string[] coordinates = line.Split(' ');
                float x, y, z = 0f;
                x = float.Parse(coordinates[1]);
                y = float.Parse(coordinates[2]);
                z = float.Parse(coordinates[3]);
                // sometimes the depth(Z) of an inferred joint may show as negative
                // clamp down to 0.1f to prevent coordinatemapper from returning (-Infinity, -Infinity)
                if (z < 0)
                {
                    z = InferredZPositionClamp;
                }
                CameraSpacePoint position = new CameraSpacePoint();
                position.X = x;
                position.Y = y;
                position.Z = z;
                DepthSpacePoint depthSpacePoint = this.coordinateMapper.MapCameraPointToDepthSpace(position);
                Point point = new Point(depthSpacePoint.X, depthSpacePoint.Y);
                joints.Add(point);
                drawingContext.DrawEllipse(this.ArchetypeBrush, null, point, JointThickness, JointThickness);
            }
            //////  DRAW BODY
            //# index = [3, 2; 2, 4; 2, 8; 2, 1; 1, 0; 0, 12; 0, 16;... % Torso
            //#  4, 5; 5, 6; 6, 7;... % Left arm
            //#  8, 9; 9, 10; 10, 11;... % Right arm
            //#  12, 13; 13, 14; 14, 15;... % Left leg
            //#  16, 17; 17, 18; 18, 19;]... % Right leg
            drawingContext.DrawLine(this.ArchetypePen, joints[3], joints[2]);
            drawingContext.DrawLine(this.ArchetypePen, joints[2], joints[4]);
            drawingContext.DrawLine(this.ArchetypePen, joints[2], joints[8]);
            drawingContext.DrawLine(this.ArchetypePen, joints[2], joints[1]);
            drawingContext.DrawLine(this.ArchetypePen, joints[1], joints[0]);
            drawingContext.DrawLine(this.ArchetypePen, joints[0], joints[12]);
            drawingContext.DrawLine(this.ArchetypePen, joints[0], joints[16]);
            drawingContext.DrawLine(this.ArchetypePen, joints[4], joints[5]);
            drawingContext.DrawLine(this.ArchetypePen, joints[5], joints[6]);
            drawingContext.DrawLine(this.ArchetypePen, joints[6], joints[7]);
            drawingContext.DrawLine(this.ArchetypePen, joints[8], joints[9]);
            drawingContext.DrawLine(this.ArchetypePen, joints[9], joints[10]);
            drawingContext.DrawLine(this.ArchetypePen, joints[10], joints[11]);
            drawingContext.DrawLine(this.ArchetypePen, joints[12], joints[13]);
            drawingContext.DrawLine(this.ArchetypePen, joints[13], joints[14]);
            drawingContext.DrawLine(this.ArchetypePen, joints[14], joints[15]);
            drawingContext.DrawLine(this.ArchetypePen, joints[16], joints[17]);
            drawingContext.DrawLine(this.ArchetypePen, joints[17], joints[18]);
            drawingContext.DrawLine(this.ArchetypePen, joints[18], joints[19]);
        }

        /// <summary>
        /// Draws one bone of a body (joint to joint)
        /// </summary>
        /// <param name="joints">joints to draw</param>
        /// <param name="jointPoints">translated positions of joints to draw</param>
        /// <param name="jointType0">first joint of bone to draw</param>
        /// <param name="jointType1">second joint of bone to draw</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        /// /// <param name="drawingPen">specifies color to draw a specific bone</param>
        private void DrawBone(IReadOnlyDictionary<JointType, Joint> joints, IDictionary<JointType, Point> jointPoints, JointType jointType0, JointType jointType1, DrawingContext drawingContext, Pen drawingPen)
        {
            Joint joint0 = joints[jointType0];
            Joint joint1 = joints[jointType1];

            // If we can't find either of these joints, exit
            if (joint0.TrackingState == TrackingState.NotTracked ||
                joint1.TrackingState == TrackingState.NotTracked)
            {
                return;
            }

            // We assume all drawn bones are inferred unless BOTH joints are tracked
            Pen drawPen = this.inferredBonePen;
            if ((joint0.TrackingState == TrackingState.Tracked) && (joint1.TrackingState == TrackingState.Tracked))
            {
                drawPen = drawingPen;
            }

            drawingContext.DrawLine(drawPen, jointPoints[jointType0], jointPoints[jointType1]);
        }

        /// <summary>
        /// Draws a hand symbol if the hand is tracked: red circle = closed, green circle = opened; blue circle = lasso
        /// </summary>
        /// <param name="handState">state of the hand</param>
        /// <param name="handPosition">position of the hand</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        private void DrawHand(HandState handState, Point handPosition, DrawingContext drawingContext)
        {
            switch (handState)
            {
                case HandState.Closed:
                    drawingContext.DrawEllipse(this.handClosedBrush, null, handPosition, HandSize, HandSize);
                    break;

                case HandState.Open:
                    drawingContext.DrawEllipse(this.handOpenBrush, null, handPosition, HandSize, HandSize);
                    break;

                case HandState.Lasso:
                    drawingContext.DrawEllipse(this.handLassoBrush, null, handPosition, HandSize, HandSize);
                    break;
            }
        }

        /// <summary>
        /// Draws indicators to show which edges are clipping body data
        /// </summary>
        /// <param name="body">body to draw clipping information for</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        private void DrawClippedEdges(Body body, DrawingContext drawingContext)
        {
            FrameEdges clippedEdges = body.ClippedEdges;

            if (clippedEdges.HasFlag(FrameEdges.Bottom))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, this.displayHeight - ClipBoundsThickness, this.displayWidth, ClipBoundsThickness));
            }

            if (clippedEdges.HasFlag(FrameEdges.Top))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, 0, this.displayWidth, ClipBoundsThickness));
            }

            if (clippedEdges.HasFlag(FrameEdges.Left))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, 0, ClipBoundsThickness, this.displayHeight));
            }

            if (clippedEdges.HasFlag(FrameEdges.Right))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(this.displayWidth - ClipBoundsThickness, 0, ClipBoundsThickness, this.displayHeight));
            }
        }

        /// <summary>
        /// Handles the event which the sensor becomes unavailable (E.g. paused, closed, unplugged).
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Sensor_IsAvailableChanged(object sender, IsAvailableChangedEventArgs e)
        {
            // on failure, set the status text
            this.StatusText = this.kinectSensor.IsAvailable ? Properties.Resources.RunningStatusText
                                                            : Properties.Resources.SensorNotAvailableStatusText;
        }


        /////////////////////////////////////////////////////////////////////////////////
        /// EMS PART + Button Events
        /////////////////////////////////////////////////////////////////////////////////
        // SERIAL (USB) PORT
        private string sPort = "COM4";
        private int baudrate = 19200;
        private void SendUSBMessage(string message)
        {
            SerialPort port = new SerialPort(sPort, baudrate);
            port.Open();
            port.Write(message);
            port.Close();
        }
        
        // UDP IP
        const string ipAddress = "192.168.43.1"; // Android Hotspot ip
        const int port = 5005;
        private long delay1 = 200;
        private long lastMessage1 = 0;
        private long intensity1 = 100;
        private long delay2 = 200;
        private long lastMessage2 = 0;
        private long intensity2 = 100;
        private long time = 2000;

        private void SendUDPMessage(string message)
        {
            var client = new UdpClient();
            var ep = new IPEndPoint(IPAddress.Parse(ipAddress), port);
            client.Connect(ep);
            var data = Encoding.ASCII.GetBytes(message);
            client.Send(data, data.Length);
            Console.WriteLine($"[{ipAddress}:{port}]: {message}");
        }

        // BLE
        const string DEVICE_MAC_ADDRESS = "00:1E:C0:32:59:B2"; //Timeular's MAC address
        const string BLUETOOTH_LE_SERVICE_UUID = "454D532D-5374-6575-6572-756E672D4348"; //the service the different characteristics
        const string BLUETOOTH_LE_CHARACTERISTIC_UUID = "c7e70012-c847-11e6-8175-8c89a55d403c"; //the characteristic that allows subscription to notification

        private async void sendBLEMessage(string message)
        {
            BluetoothLEDevice bluetoothLEDevice = null;

            // Not working, deviceInformationCollection.Count = 0. 0 devices discovered
            DeviceInformationCollection deviceInformationCollection = await DeviceInformation.FindAllAsync(BluetoothLEDevice.GetDeviceSelector());
            Console.WriteLine($"Detected [{deviceInformationCollection.Count}] BLE devices");

            //var address = new BluetoothAddressType();
            //var dev = await BluetoothLEDevice.FromBluetoothAddressAsync(address);
            //Console.WriteLine(dev);


            foreach (var deviceInformation in deviceInformationCollection)
            {
                String deviceInformationId = deviceInformation.Id;
                String mac = deviceInformationId.Substring(deviceInformationId.Length - 17);
                Console.WriteLine($"Detected Bluetooth LE Device [{mac}]:");
                if (mac.Equals(DEVICE_MAC_ADDRESS))
                {
                    bluetoothLEDevice = await BluetoothLEDevice.FromIdAsync(deviceInformation.Id);
                    Debug.WriteLine($"Found Bluetooth LE Device [{mac}]: {bluetoothLEDevice.ConnectionStatus}");
                    break;
                }
            }
        }

        // Buttons
        private float iMax = 100;

        private void EMS1C1Plus(object sender, RoutedEventArgs e)
        {
            if ((DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) > lastMessage1 + delay1) {
                if (intensity1+5 < iMax) { 
                    intensity1 += 5;
                    //SendUDPMessage("EMS09RH" + "C1" + "I" + intensity1 + "T" + time + "G");
                    SendUSBMessage("C0" + "I" + intensity1 + "T" + time + "G");
                    lastMessage1 = (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                    Console.WriteLine("[EMS1C1+] Increasing Intensity of EMS Module 1 Channel 1 to: "+intensity1);
                    //sendBLEMessage("meh.");
                }
            } else {
                Console.WriteLine("[EMS1C1+] ERR waiting for delay");
            }
        }

        private void EMS1C1Minus(object sender, RoutedEventArgs e)
        {
            if ((DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) > lastMessage1 + delay1) {
                if (intensity1-5 > 0) { 
                    intensity1 -= 5;
                    //SendUDPMessage("EMS09RH" + "C1" + "I" + intensity1 + "T" + time + "G");
                    SendUSBMessage("C0" + "I" + intensity1 + "T" + time + "G");
                    lastMessage1 = (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                    Console.WriteLine("[EMS1C1-] Decreasing Intensity of EMS Module 1 Channel 1 to: " + intensity1);
                }
            }
            else {
                Console.WriteLine("[EMS1C1-] ERR waiting for delay");
            }
        }

        private void EMS1C2Plus(object sender, RoutedEventArgs e)
        {
            if ((DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) > lastMessage1 + delay1) {
                if (intensity1 + 5 < iMax) {
                    intensity1 += 5;
                    //SendUDPMessage("EMS09RH" + "C2" + "I" + intensity1 + "T" + time + "G");
                    SendUSBMessage("C1" + "I" + intensity1 + "T" + time + "G");
                    lastMessage1 = (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                    Console.WriteLine("[EMS1C2+] Increasing (+) Intensity of EMS Module 1 Channel 2 to: " + intensity1);
                }
            }
            else {
                Console.WriteLine("[EMS1C2+] ERR waiting for delay);");
            }
        }

        private void EMS1C2Minus(object sender, RoutedEventArgs e)
        {
            if ((DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) > lastMessage1 + delay1)
            {
                if (intensity1 - 5 > 0) {
                    intensity1 -= 5;
                    //SendUDPMessage("EMS09RH" + "C2" + "I" + intensity1 + "T" + time + "G");
                    SendUSBMessage("C1" + "I" + intensity1 + "T" + time + "G");
                    lastMessage1 = (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                    Console.WriteLine("[EMS1C2-] Decreasing (-) Intensity of EMS Module 1 Channel 2 to: " + intensity1);
                }
            }
            else { 
                Console.WriteLine("[EMS1C2-] ERR waiting for delay);");
            }
        }

        // Second EMS Machine
        private void EMS2C1Plus(object sender, RoutedEventArgs e)
        {
            Console.WriteLine("[EMS2C1+] Increasing (+) Intensity of EMS Module 2 Channel 1");
        }

        private void EMS2C1Minus(object sender, RoutedEventArgs e)
        {
            Console.WriteLine("[EMS2C1-] Decreasing (-) Intensity of EMS Module 2 Channel 1");
        }

        private void EMS2C2Plus(object sender, RoutedEventArgs e)
        {
            Console.WriteLine("[EMS2C2+] Increasing (+) Intensity of EMS Module 2 Channel 2");
        }

        private void EMS2C2Minus(object sender, RoutedEventArgs e)
        {
            Console.WriteLine("[EMS2C2-] Decreasing (-) Intensity of EMS Module 2 Channel 2");
        }

        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
    }
}
