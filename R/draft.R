#df <- read.table("P20S3Q3.txt", header = FALSE, sep = " ")
#df

library("rgl")
rgl.open() # Open a new RGL device


df = read.delim("P20S3Q3.txt", header = FALSE, sep = " ", dec = ".")
df = df[-1,]

x = head(df[2],25)
y = head(df[3],25)
z = head(df[4],25)
#zmat <- matrix(z, length(x),length(y))
#persp3d(x=x, y=y, z=z)

rgl.bg(color = "white")
# adding points
rgl.points(x[[1]], y[[1]], z[[1]], color = "blue", size = 5) # Scatter plot
# adding lines
# index = [3, 2; 2, 4; 2, 8; 2, 1; 1, 0; 0, 12; 0, 16;... % Torso
#  4, 5; 5, 6; 6, 7;... % Left arm
#  8, 9; 9, 10; 10, 11;... % Right arm
#  12, 13; 13, 14; 14, 15;... % Left leg
#  16, 17; 17, 18; 18, 19;]... % Right leg
#  + 1; % C index to matlab index
## torso
rgl.lines(c(df[4,2], df[3,2]), c(df[4,3], df[3,3]), c(df[4,4], df[3,4]), color = "blue") # 3, 2
rgl.lines(c(df[3,2], df[5,2]), c(df[3,3], df[5,3]), c(df[3,4], df[5,4]), color = "blue") # 2, 4
rgl.lines(c(df[3,2], df[9,2]), c(df[3,3], df[9,3]), c(df[3,4], df[9,4]), color = "blue") # 2, 8
rgl.lines(c(df[3,2], df[2,2]), c(df[3,3], df[2,3]), c(df[3,4], df[2,4]), color = "blue") # 2, 1
rgl.lines(c(df[2,2], df[1,2]), c(df[2,3], df[1,3]), c(df[2,4], df[1,4]), color = "blue") # 1, 0
rgl.lines(c(df[1,2], df[13,2]), c(df[1,3], df[13,3]), c(df[1,4], df[13,4]), color = "blue") # 0, 12
rgl.lines(c(df[1,2], df[17,2]), c(df[1,3], df[17,3]), c(df[1,4], df[17,4]), color = "blue") # 0, 16
## left arm
rgl.lines(c(df[5,2], df[6,2]), c(df[5,3], df[6,3]), c(df[5,4], df[6,4]), color = "blue") # 4, 5
rgl.lines(c(df[6,2], df[7,2]), c(df[6,3], df[7,3]), c(df[6,4], df[7,4]), color = "blue") # 5, 6
rgl.lines(c(df[7,2], df[8,2]), c(df[7,3], df[8,3]), c(df[7,4], df[8,4]), color = "blue") # 6, 7
## right arm
rgl.lines(c(df[9,2], df[10,2]), c(df[9,3], df[10,3]), c(df[9,4], df[10,4]), color = "blue") # 8, 9
rgl.lines(c(df[10,2], df[11,2]), c(df[10,3], df[11,3]), c(df[10,4], df[11,4]), color = "blue") # 9, 10
rgl.lines(c(df[11,2], df[12,2]), c(df[11,3], df[12,3]), c(df[11,4], df[12,4]), color = "blue") # 10, 11
## left leg
rgl.lines(c(df[13,2], df[14,2]), c(df[13,3], df[14,3]), c(df[13,4], df[14,4]), color = "blue") # 12, 13
rgl.lines(c(df[14,2], df[15,2]), c(df[14,3], df[15,3]), c(df[14,4], df[15,4]), color = "blue") # 13, 14
rgl.lines(c(df[15,2], df[16,2]), c(df[15,3], df[16,3]), c(df[15,4], df[16,4]), color = "blue") # 14, 15
## right leg
rgl.lines(c(df[17,2], df[18,2]), c(df[17,3], df[18,3]), c(df[17,4], df[18,4]), color = "blue") # 16, 17
rgl.lines(c(df[18,2], df[19,2]), c(df[18,3], df[19,3]), c(df[18,4], df[19,4]), color = "blue") # 17, 18
rgl.lines(c(df[19,2], df[20,2]), c(df[19,3], df[20,3]), c(df[19,4], df[20,4]), color = "blue") # 18, 19
# hand left
rgl.lines(c(df[8,2], df[23,2]), c(df[8,3], df[23,3]), c(df[8,4], df[23,4]), color = "blue") # 7, 22
rgl.lines(c(df[8,2], df[22,2]), c(df[8,3], df[22,3]), c(df[8,4], df[22,4]), color = "blue") # 7, 21
# hand right
rgl.lines(c(df[12,2], df[24,2]), c(df[12,3], df[24,3]), c(df[12,4], df[24,4]), color = "blue") # 11, 23
rgl.lines(c(df[12,2], df[25,2]), c(df[12,3], df[25,3]), c(df[12,4], df[25,4]), color = "blue") # 11, 24





