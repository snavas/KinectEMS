printMeanSkeleton <- function(myFiles,output="test.txt"){
  mycolor = "purple"
  n = length(myFiles)
  
  x <- numeric(25)
  y <- numeric(25)
  z <- numeric(25)
  
  for (i in 1:n){
    skel = read.delim(myFiles[i], header = FALSE, sep = " ", dec = ".")
    skel = skel[-1,]
    for (j in 1:25){
      #skel[j,2:4] = t(rotationX%*%t(skel[j,2:4]))
      x[j] = x[j] + skel[j,2]
      y[j] = y[j] + skel[j,3]
      z[j] = z[j] + skel[j,4]
    }
  }
  
  for (i in 1:25){
    x[i] = x[i]/n
    y[i] = y[i]/n
    z[i] = z[i]/n
  }
  
  #library("rgl")
  # adding points
  rgl.points(x, y, z, color = mycolor, size = 5) # Scatter plot
  # adding joints
  # index = [3, 2; 2, 4; 2, 8; 2, 1; 1, 0; 0, 12; 0, 16;... % Torso
  #  4, 5; 5, 6; 6, 7;... % Left arm
  #  8, 9; 9, 10; 10, 11;... % Right arm
  #  12, 13; 13, 14; 14, 15;... % Left leg
  #  16, 17; 17, 18; 18, 19;]... % Right leg
  #  + 1; % C index to matlab index
  df <- data.frame(x, y, z)
  write.table(df, file = output)
  ## torso
  segments3d(c(df[4,1], df[3,1]), c(df[4,2], df[3,2]), c(df[4,3], df[3,3]), color = mycolor) # 3, 2
  segments3d(c(df[3,1], df[5,1]), c(df[3,2], df[5,2]), c(df[3,3], df[5,3]), color = mycolor) # 2, 4
  segments3d(c(df[3,1], df[9,1]), c(df[3,2], df[9,2]), c(df[3,3], df[9,3]), color = mycolor) # 2, 8
  segments3d(c(df[3,1], df[2,1]), c(df[3,2], df[2,2]), c(df[3,3], df[2,3]), color = mycolor) # 2, 1
  segments3d(c(df[2,1], df[1,1]), c(df[2,2], df[1,2]), c(df[2,3], df[1,3]), color = mycolor) # 1, 0
  segments3d(c(df[1,1], df[13,1]), c(df[1,2], df[13,2]), c(df[1,3], df[13,3]), color = mycolor) # 0, 12
  segments3d(c(df[1,1], df[17,1]), c(df[1,2], df[17,2]), c(df[1,3], df[17,3]), color = mycolor) # 0, 16
  ## left arm
  segments3d(c(df[5,1], df[6,1]), c(df[5,2], df[6,2]), c(df[5,3], df[6,3]), color = mycolor) # 4, 5
  segments3d(c(df[6,1], df[7,1]), c(df[6,2], df[7,2]), c(df[6,3], df[7,3]), color = mycolor) # 5, 6
  segments3d(c(df[7,1], df[8,1]), c(df[7,2], df[8,2]), c(df[7,3], df[8,3]), color = mycolor) # 6, 7
  ## right arm
  segments3d(c(df[9,1], df[10,1]), c(df[9,2], df[10,2]), c(df[9,3], df[10,3]), color = mycolor) # 8, 9
  segments3d(c(df[10,1], df[11,1]), c(df[10,2], df[11,2]), c(df[10,3], df[11,3]), color = mycolor) # 9, 10
  segments3d(c(df[11,1], df[12,1]), c(df[11,2], df[12,2]), c(df[11,3], df[12,3]), color = mycolor) # 10, 11
  # left leg
  segments3d(c(df[13,1], df[14,1]), c(df[13,2], df[14,2]), c(df[13,3], df[14,3]), color = mycolor) # 12, 13
  segments3d(c(df[14,1], df[15,1]), c(df[14,2], df[15,2]), c(df[14,3], df[15,3]), color = mycolor) # 13, 14
  segments3d(c(df[15,1], df[16,1]), c(df[15,2], df[16,2]), c(df[15,3], df[16,3]), color = mycolor) # 14, 15
  # right leg
  segments3d(c(df[17,1], df[18,1]), c(df[17,2], df[18,2]), c(df[17,3], df[18,3]), color = mycolor) # 16, 17
  segments3d(c(df[18,1], df[19,1]), c(df[18,2], df[19,2]), c(df[18,3], df[19,3]), color = mycolor) # 17, 18
  segments3d(c(df[19,1], df[20,1]), c(df[19,2], df[20,2]), c(df[19,3], df[20,3]), color = mycolor) # 18, 19
  # hand left
  segments3d(c(df[8,1], df[23,1]), c(df[8,2], df[23,2]), c(df[8,3], df[23,3]), color = mycolor) # 7, 22
  segments3d(c(df[8,1], df[22,1]), c(df[8,2], df[22,2]), c(df[8,3], df[22,3]), color = mycolor) # 7, 21
  # hand right
  segments3d(c(df[12,1], df[24,1]), c(df[12,2], df[24,2]), c(df[12,3], df[24,3]), color = mycolor) # 11, 23
  segments3d(c(df[12,1], df[25,1]), c(df[12,2], df[25,2]), c(df[12,3], df[25,3]), color = mycolor) # 11, 24
  
  right = TRUE
  if (right) {
     rgl.abclines(x = df[9,1], y = df[9,2], z = df[9,3], a = c(df[11,1]-df[9,1],df[11,2]-df[9,2],df[11,3]-df[9,3]),thickness = 2, color = mycolor)
  } else {
    rgl.abclines(x = df[5,1], y = df[5,2], z = df[5,3], a = c(df[7,1]-df[5,1],df[7,2]-df[5,2],df[7,3]-df[5,3]),thickness = 2, color = mycolor)
  }
}

printSkeleton <- function(myFile, mycolor="blue", right=TRUE){
  df = read.delim(myFile, header = FALSE, sep = " ", dec = ".")
  df = df[-1,]
  
  #df = df*rotationX
  #for (i in 1:25){
  #  df[i,2:4] = t(rotationX%*%t(df[i,2:4]))
  #}
  
  x = head(df[2],25)
  y = head(df[3],25)
  z = head(df[4],25)
  
  if (right) {
    rgl.abclines(x = df[9,2], y = df[9,3], z = df[9,4], a = c(df[11,2]-df[9,2],df[11,3]-df[9,3],df[11,4]-df[9,4]),thickness = 2, color = mycolor)
  } else {
    rgl.abclines(x = df[5,2], y = df[5,3], z = df[5,4], a = c(df[7,2]-df[5,2],df[7,3]-df[5,3],df[7,4]-df[5,4]),thickness = 2, color = mycolor)
  }
  
  #library("rgl")
  # adding points
  rgl.points(x[[1]], y[[1]], z[[1]], color = mycolor, size = 5) # Scatter plot
  # adding joints
  # index = [3, 2; 2, 4; 2, 8; 2, 1; 1, 0; 0, 12; 0, 16;... % Torso
  #  4, 5; 5, 6; 6, 7;... % Left arm
  #  8, 9; 9, 10; 10, 11;... % Right arm
  #  12, 13; 13, 14; 14, 15;... % Left leg
  #  16, 17; 17, 18; 18, 19;]... % Right leg
  #  + 1; % C index to matlab index
  ## torso
  segments3d(c(df[4,2], df[3,2]), c(df[4,3], df[3,3]), c(df[4,4], df[3,4]), color = mycolor) # 3, 2
  segments3d(c(df[3,2], df[5,2]), c(df[3,3], df[5,3]), c(df[3,4], df[5,4]), color = mycolor) # 2, 4
  segments3d(c(df[3,2], df[9,2]), c(df[3,3], df[9,3]), c(df[3,4], df[9,4]), color = mycolor) # 2, 8
  segments3d(c(df[3,2], df[2,2]), c(df[3,3], df[2,3]), c(df[3,4], df[2,4]), color = mycolor) # 2, 1
  segments3d(c(df[2,2], df[1,2]), c(df[2,3], df[1,3]), c(df[2,4], df[1,4]), color = mycolor) # 1, 0
  segments3d(c(df[1,2], df[13,2]), c(df[1,3], df[13,3]), c(df[1,4], df[13,4]), color = mycolor) # 0, 12
  segments3d(c(df[1,2], df[17,2]), c(df[1,3], df[17,3]), c(df[1,4], df[17,4]), color = mycolor) # 0, 16
  ## left arm
  segments3d(c(df[5,2], df[6,2]), c(df[5,3], df[6,3]), c(df[5,4], df[6,4]), color = mycolor) # 4, 5
  segments3d(c(df[6,2], df[7,2]), c(df[6,3], df[7,3]), c(df[6,4], df[7,4]), color = mycolor) # 5, 6
  segments3d(c(df[7,2], df[8,2]), c(df[7,3], df[8,3]), c(df[7,4], df[8,4]), color = mycolor) # 6, 7
  ## right arm
  segments3d(c(df[9,2], df[10,2]), c(df[9,3], df[10,3]), c(df[9,4], df[10,4]), color = mycolor) # 8, 9
  segments3d(c(df[10,2], df[11,2]), c(df[10,3], df[11,3]), c(df[10,4], df[11,4]), color = mycolor) # 9, 10
  segments3d(c(df[11,2], df[12,2]), c(df[11,3], df[12,3]), c(df[11,4], df[12,4]), color = mycolor) # 10, 11
  ## left leg
  segments3d(c(df[13,2], df[14,2]), c(df[13,3], df[14,3]), c(df[13,4], df[14,4]), color = mycolor) # 12, 13
  segments3d(c(df[14,2], df[15,2]), c(df[14,3], df[15,3]), c(df[14,4], df[15,4]), color = mycolor) # 13, 14
  segments3d(c(df[15,2], df[16,2]), c(df[15,3], df[16,3]), c(df[15,4], df[16,4]), color = mycolor) # 14, 15
  ## right leg
  segments3d(c(df[17,2], df[18,2]), c(df[17,3], df[18,3]), c(df[17,4], df[18,4]), color = mycolor) # 16, 17
  segments3d(c(df[18,2], df[19,2]), c(df[18,3], df[19,3]), c(df[18,4], df[19,4]), color = mycolor) # 17, 18
  segments3d(c(df[19,2], df[20,2]), c(df[19,3], df[20,3]), c(df[19,4], df[20,4]), color = mycolor) # 18, 19
  # hand left
  segments3d(c(df[8,2], df[23,2]), c(df[8,3], df[23,3]), c(df[8,4], df[23,4]), color = mycolor) # 7, 22
  segments3d(c(df[8,2], df[22,2]), c(df[8,3], df[22,3]), c(df[8,4], df[22,4]), color = mycolor) # 7, 21
  # hand right
  segments3d(c(df[12,2], df[24,2]), c(df[12,3], df[24,3]), c(df[12,4], df[24,4]), color = mycolor) # 11, 23
  segments3d(c(df[12,2], df[25,2]), c(df[12,3], df[25,3]), c(df[12,4], df[25,4]), color = mycolor) # 11, 24
}

drawCanvas <- function(alpha=0, debug=FALSE){
  library("rgl")
  library(matlib)
  rgl.open() # Open a new RGL device
  # Printing the origin 
  rgl.bg(color = "white")
  #segments3d(c(0, 1), c(0, 0), c(0, 0), color = "blue")
  #segments3d(c(0, 0), c(0,1), c(0, 0), color = "red")
  #segments3d(c(0, 0), c(0, 0), c(0,1), color = "green")
  vectors3d(c(0, 0, 1), color = "blue")
  vectors3d(c(0, 1, 0), color = "red")
  vectors3d(c(1, 0, 0), color = "green")
  
  rgl.spheres(0, 0, 0, r = 0.1, color = "black")  # Scatter plot
  # quads3d(c(0,1,1,0), c(0,0,1,1), c(0,0,0,0), lit = F, color = "grey")
  # quads3d(c(0,-1,-1,0), c(0,0,1,1), c(0,1,1,0), lit = F, color = "grey")
  # quads3d(c(1,1,2,2), c(0,1,1,0), c(0,0,1,1), lit = F, color = "grey")
  # Coordinated shifted -0.5 on X axis
  #quads3d(c(-0.5,0.5,0.5,-0.5), c(0,0,1,1), c(0,0,0,0), lit = F, color = "grey")
  #quads3d(c(-0.5,-1.5,-1.5,-0.5), c(0,0,1,1), c(0,1,1,0), lit = F, color = "grey")
  #quads3d(c(0.5,0.5,1.5,1.5), c(0,1,1,0), c(0,0,1,1), lit = F, color = "grey")
  # IVE SIZE
  #quads3d(c(-1.10,1.10,1.10,-1.10), c(0,0,1.63,1.63), c(0,0,0,0), lit = F, color = "grey") #Panel A
  #quads3d(c(-1.10,1.10,1.10,-1.10), c(0,0,-0.5,-0.5), c(0,0,0,0), lit = F, color = "black") # Underpanel A
  #quads3d(c(-2.15,-1.10,-1.10,-2.15), c(0,0,1.63,1.63), c(1.81,0,0,1.81), lit = F, color = "grey") #Panel B
  #quads3d(c(-2.15,-1.10,-1.10,-2.15), c(0,0,-0.5,-0.5), c(1.81,0,0,1.81), lit = F, color = "black") #Underpanel B
  #quads3d(c(1.10,2.15,2.15,1.10), c(0,0,1.63,1.63), c(0,1.81,1.81,0), lit = F, color = "grey") #Panel C
  #quads3d(c(1.10,2.15,2.15,1.10), c(0,0,-0.5,-0.5), c(0,1.81,1.81,0), lit = F, color = "black") #Underpanel C 
  
  # IVE SIZE (Y shifted)
  #s = 0.3 #meters
  #quads3d(c(-1.10,1.10,1.10,-1.10), c(0+s,0+s,1.63+s,1.63+s), c(0,0,0,0), lit = F, color = "grey") #Panel A
  #quads3d(c(-1.10,1.10,1.10,-1.10), c(0+s,0+s,-0.5+s,-0.5+s), c(0,0,0,0), lit = F, color = "black") # Underpanel A
  #quads3d(c(-2.15,-1.10,-1.10,-2.15), c(0+s,0+s,1.63+s,1.63+s), c(1.81,0,0,1.81), lit = F, color = "grey") #Panel B
  #quads3d(c(-2.15,-1.10,-1.10,-2.15), c(0+s,0+s,-0.5+s,-0.5+s), c(1.81,0,0,1.81), lit = F, color = "black") #Underpanel B
  #quads3d(c(1.10,2.15,2.15,1.10), c(0+s,0+s,1.63+s,1.63+s), c(0,1.81,1.81,0), lit = F, color = "grey") #Panel C
  #quads3d(c(1.10,2.15,2.15,1.10), c(0+s,0+s,-0.5+s,-0.5+s), c(0,1.81,1.81,0), lit = F, color = "black") #Underpanel C 
  
  s = 0.33 #vertical shift in meters
  f = -0.36 # floor in meters
  #pi = c(x, y, z)
  p1 = c(-1.10, 1.63+s, 0)
  p2 = c(1.10, 1.63+s, 0)
  p3 = c(-1.10, 0+s, 0)
  p4 = c(1.10, 0+s, 0)
  p5 = c(-2.15, 1.63+s, 1.81)
  p6 = c(-2.15, 0+s, 1.81)
  p7 = c(2.15, 1.63+s, 1.81)
  p8 = c(2.15, 0+s, 1.81)
  p9 = c(-1.10, f, 0)
  p10 = c(1.10, f, 0)
  p11 = c(-2.15, f, 1.81)
  p12 = c(2.15, f, 1.81)
  df = data.frame(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
  df <- t(df)
  df <- as.data.frame(df)
  
  # Rotation
  #alpha = -15
  alpha = (alpha * pi) / (180)
  rotationX = rbind(c(1,0,0),
                    c(0,cos(alpha),-sin(alpha)),
                    c(0,sin(alpha),cos(alpha)))
  rotationY = rbind(c(cos(alpha),0,sin(alpha)),
                    c(0,1,0),
                    c(-sin(alpha),0,cos(alpha)))
  rotationZ = rbind(c(cos(alpha),-sin(alpha),0),
                    c(sin(alpha),cos(alpha),0),
                    c(0,0,1))
  #df = df*rotationX
  for (i in 1:25){
    df[i,1:3] = t(rotationX%*%t(df[i,1:3]))
  }
  
  quads3d(c(df[3,1],df[4,1],df[2,1],df[1,1]), c(df[3,2],df[4,2],df[2,2],df[1,2]), c(df[3,3],df[4,3],df[2,3],df[1,3]), lit = F, color = "grey") #Panel A
  quads3d(c(df[5,1],df[6,1],df[3,1],df[1,1]), c(df[5,2],df[6,2],df[3,2],df[1,2]), c(df[5,3],df[6,3],df[3,3],df[1,3]), lit = F, color = "grey") #Panel B
  quads3d(c(df[2,1],df[7,1],df[8,1],df[4,1]), c(df[2,2],df[7,2],df[8,2],df[4,2]), c(df[2,3],df[7,3],df[8,3],df[4,3]), lit = F, color = "grey") #Panel C
  quads3d(c(df[3,1],df[4,1],df[10,1],df[9,1]), c(df[3,2],df[4,2],df[10,2],df[9,2]), c(df[3,3],df[4,3],df[10,3],df[9,3]), lit = F, color = "black") # Underpanel A
  quads3d(c(df[6,1],df[3,1],df[9,1],df[11,1]), c(df[6,2],df[3,2],df[9,2],df[11,2]), c(df[6,3],df[3,3],df[9,3],df[11,3]), lit = F, color = "black") #Underpanel B
  quads3d(c(df[4,1],df[8,1],df[12,1],df[10,1]), c(df[4,2],df[8,2],df[12,2],df[10,2]), c(df[4,3],df[8,3],df[12,3],df[10,3]), lit = F, color = "black") #Underpanel C 
  
  ######################### DEBUG ##############################
  if (debug) bbox3d(color = c("#333377", "black"), emission = "#333377", specular = "#3333FF", shininess = 5, alpha = 0.8)
  ##############################################################
}