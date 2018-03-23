library(shiny)
library(caret)
library(datasets)
library(randomForest)
library(e1071)

# Define server logic required predict the iris species
shinyServer(function(input, output) 
{
    # Generate random forest model for iris data
    set.seed(2602)
    inTrain <- createDataPartition(y = iris$Species, p = 0.8, list = FALSE)
    trainData <- iris[inTrain, ]
    testData <- iris[-inTrain, ]
    
    modFit <- train(Species ~ ., data = trainData, method = 'rf',
                    trControl = trainControl(method = "cv",
                                             number = 2))
    
    # Generate predicted value  
    modPred <- reactive(
        {
            predict(modFit, 
                    newdata = data.frame(Sepal.Length = input$Sepal.Length,
                                         Sepal.Width = input$Sepal.Width,
                                         Petal.Length = input$Petal.Length,
                                         Petal.Width = input$Petal.Width))
        })
    
    output$plotCharacteristics <- renderPlot(
        {
            inputSepalLength = input$Sepal.Length
            inputSepalWidth = input$Sepal.Width
            inputPetalLength = input$Petal.Length
            inputPetalWidth = input$Petal.Width
            
            par(mfrow=c(1,2))
            palette(c("cyan","purple","green"))
            
            # Plot with values for sepal characteristics
            plot(iris$Sepal.Length, iris$Sepal.Width,
                 xlab = "Sepal Length [cm]",
                 ylab = "Sepal Width [cm]", col = iris$Species, pch = 16,
                 xlim = c(4, 8), ylim = c(1.5, 5))
            legend('topleft', c("Setosa", "Versicolor", "Virigina"),
                   col = unique(iris$Species), pch=21)
            points(inputSepalLength, inputSepalWidth, 
                   col = "red", pch = 4, cex = 2, lwd = 4)
    
            # Plot with values for petal characteristics
            plot(iris$Petal.Length, iris$Petal.Width,
                 xlab = "Petal Length [cm]",
                 ylab = "Petal Width [cm]", col = iris$Species, pch = 16,
                 xlim = c(0, 8), ylim = c(0, 3))
            legend('topleft', c("Setosa", "Versicolor", "Virigina"),
                   col = unique(iris$Species), pch=21)
            points(inputPetalLength, inputPetalWidth, 
                   col = "red", pch = 4, cex = 2, lwd = 4)
    
        })
    
    output$predSpecies <- renderText(
        {
            species <- toupper(as.character(modPred()))
            paste("<b> <font color=red>", species, "</font> </b>")
        })
    
    output$imageSpecies <- renderImage(
        {
            # When input$n is 1, filename is ./images/image1.jpeg
            filename <- normalizePath(file.path('./www',
                                                paste(modPred(), '.jpg', sep='')))
            
            # Return a list containing the filename
            list(src = filename, height = 150, width = 150)
        }, deleteFile = FALSE)
})

