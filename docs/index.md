---
title       : "Pitch Presentation for shiny app"
subtitle    : "Predict iris species"
author      : "Simone Kraemer"
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<style type="text/css">
code
{ /* Code block */
    font-size: 15px;
    line-height: 1.0;
}
pre { /* Code block - determines code spacing between lines */
    font-size: 15px;
    line-height: 1.0;
}
</style>




## General
The shiny app "Predict iris species" can predict the iris species based on four
characteristics that the user can select via sliders on the left side:
- Sepal length
- Sepal width
- Petal length
- Petal width

On the right side the characteristics linked to the species are shown, as well as
the user input. Below the plots the output is shown which is the name of the 
predicted species and an image of it.

The app can be found at https://simonekraemer.shinyapps.io/predictirisspecies/

---

## How the app works I

The app generates a random forest model out of the iris dataset:

```r
set.seed(2602)
inTrain <- createDataPartition(y = iris$Species, p = 0.8, list = FALSE)
trainData <- iris[inTrain, ]
testData <- iris[-inTrain, ]

modFit <- train(Species ~ ., data = trainData, method = 'rf',
                trControl = trainControl(method = "cv",
                                         number = 2))
```

The model quality is checked on the testData:

```r
modPred <- predict(modFit, newdata = testData)
confMat <- confusionMatrix(modPred, testData$Species)
```

---

## How the app works II

Only one out of 30 species was detected wrong in the testing dataset:

```
            Reference
Prediction   setosa versicolor virginica
  setosa         10          0         0
  versicolor      0          9         0
  virginica       0          1        10
```

The accuracy is okay with 96.7%:

```
      Accuracy          Kappa  AccuracyLower  AccuracyUpper   AccuracyNull 
  9.666667e-01   9.500000e-01   8.278305e-01   9.991564e-01   3.333333e-01 
AccuracyPValue  McnemarPValue 
  2.962731e-13            NaN 
```

So this model will be used to predict the species based on the user input.

