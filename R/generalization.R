source("functions.R")

separated = TRUE
if (!separated) drawCanvas()

# Printing participants
#debug(printSkeleton)
### Example Print
if (separated) drawCanvas(alpha=15)
printSkeleton("P20S3Q7.txt", "blue")
printSkeleton("P17S3Q7.txt", "red", FALSE)
printSkeleton("P8S3Q7.txt", "green")
#debug(printMeanSkeleton)
#printMeanSkeleton(c("P20S3Q7.txt","P8S3Q7.txt"), a=-15, output="ArchetypeS3Q7.txt")
printMeanSkeleton(c("P20S3Q7.txt","P8S3Q7.txt"), output="ArchetypeS3Q7.txt")
#S1Q1
if (separated) drawCanvas()
printSkeleton("P20S1Q1.txt", "blue")
printSkeleton("P17S1Q1.txt", "red", FALSE)
printSkeleton("P8S1Q1.txt", "green")
# S1Q2
if (separated) drawCanvas()
printSkeleton("P20S1Q2.txt", "blue")
printSkeleton("P17S1Q2.txt", "red", FALSE)
printSkeleton("P8S1Q2.txt", "green")
# S1Q3
if (separated) drawCanvas()
printSkeleton("P20S1Q3.txt", "blue")
printSkeleton("P17S1Q3.txt", "red")
printSkeleton("P8S1Q3.txt", "green")
printMeanSkeleton(c("P20S3Q7.txt","P17S1Q3.txt","P8S3Q7.txt"))
# S1Q4
if (separated) drawCanvas()
printSkeleton("P20S1Q4.txt", "blue")
printSkeleton("P17S1Q4.txt", "red", FALSE)
printSkeleton("P8S1Q4.txt", "green")
# S1Q5
if (separated) drawCanvas()
printSkeleton("P20S1Q5.txt", "blue")
printSkeleton("P17S1Q5.txt", "red", FALSE)
printSkeleton("P8S1Q5.txt", "green")
# S1Q6
if (separated) drawCanvas()
printSkeleton("P20S1Q6.txt", "blue")
printSkeleton("P17S1Q6.txt", "red")
printSkeleton("P8S1Q6.txt", "green")
# S1Q7
if (separated) drawCanvas()
printSkeleton("P20S1Q7.txt", "blue")
printSkeleton("P17S1Q7.txt", "red", FALSE)
printSkeleton("P8S1Q7.txt", "green")
# S1Q8
if (separated) drawCanvas()
printSkeleton("P20S1Q8.txt", "blue")
printSkeleton("P17S1Q8.txt", "red", FALSE)
printSkeleton("P8S1Q8.txt", "green")
# S2Q1
if (separated) drawCanvas()
printSkeleton("P20S2Q1.txt", "blue")
printSkeleton("P17S2Q1.txt", "red")
printSkeleton("P8S2Q1.txt", "green")
# S2Q2
if (separated) drawCanvas()
printSkeleton("P20S2Q2.txt", "blue")
printSkeleton("P17S2Q2.txt", "red", FALSE)
printSkeleton("P8S2Q2.txt", "green")
# S2Q3
if (separated) drawCanvas()
printSkeleton("P20S2Q3.txt", "blue")
printSkeleton("P17S2Q3.txt", "red", FALSE)
printSkeleton("P8S2Q3.txt", "green")
# S2Q4
if (separated) drawCanvas()
printSkeleton("P20S2Q4.txt", "blue")
printSkeleton("P17S2Q4.txt", "red", FALSE)
printSkeleton("P8S2Q4.txt", "green")
# S2Q5
if (separated) drawCanvas()
printSkeleton("P20S2Q5.txt", "blue")
printSkeleton("P17S2Q5.txt", "red")
printSkeleton("P8S2Q5.txt", "green")
# S2Q6
if (separated) drawCanvas()
printSkeleton("P20S2Q6.txt", "blue")
printSkeleton("P17S2Q6.txt", "red")
printSkeleton("P8S2Q6.txt", "green")
# S2Q7  three right
if (separated) drawCanvas()
printSkeleton("P20S2Q7.txt", "blue")
printSkeleton("P17S2Q7.txt", "red")
printSkeleton("P8S2Q7.txt", "green")
printMeanSkeleton(c("P20S2Q7.txt","P17S2Q7.txt","P8S2Q7.txt"))
# S2Q8
if (separated) drawCanvas()
printSkeleton("P20S2Q8.txt", "blue")
printSkeleton("P17S2Q8.txt", "red", FALSE)
printSkeleton("P8S2Q8.txt", "green")
# S3Q1
if (separated) drawCanvas()
printSkeleton("P20S3Q1.txt", "blue")
printSkeleton("P17S3Q1.txt", "red")
printSkeleton("P8S3Q1.txt", "green")
# S3Q2
if (separated) drawCanvas()
printSkeleton("P20S3Q2.txt", "blue")
printSkeleton("P17S3Q2.txt", "red")
printSkeleton("P8S3Q2.txt", "green")
# S3Q3
if (separated) drawCanvas()
printSkeleton("P20S3Q3.txt", "blue")
printSkeleton("P17S3Q3.txt", "red", FALSE)
printSkeleton("P8S3Q3.txt", "green")
# S3Q4
if (separated) drawCanvas()
printSkeleton("P20S3Q4.txt", "blue", FALSE)
printSkeleton("P17S3Q4.txt", "red")
printSkeleton("P8S3Q4.txt", "green", FALSE)
# S3Q5
if (separated) drawCanvas()
printSkeleton("P20S3Q5.txt", "blue")
printSkeleton("P17S3Q5.txt", "red")
printSkeleton("P8S3Q5.txt", "green")
# S3Q6
if (separated) drawCanvas()
printSkeleton("P20S3Q6.txt", "blue")
printSkeleton("P17S3Q6.txt", "red")
printSkeleton("P8S3Q6.txt", "green")
# S3Q7
if (separated) drawCanvas()
printSkeleton("P20S3Q7.txt", "blue")
printSkeleton("P17S3Q7.txt", "red", FALSE)
printSkeleton("P8S3Q7.txt", "green")
# S3Q8
if (separated) drawCanvas()
printSkeleton("P20S3Q8.txt", "blue")
printSkeleton("P17S3Q8.txt", "red", FALSE)
printSkeleton("P8S3Q8.txt", "green")






