
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Introduction ----
# The performance of the trained models can be compared visually. This is done
# to help you to identify and choose the top performing models.

# STEP 1. Install and Load the Required Packages ----
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## randomForest ----
if (require("randomForest")) {
  require("randomForest")
} else {
  install.packages("randomForest", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# STEP 2. Load the Dataset ----
data(Glass)

# STEP 3. The Resamples Function
# We train the following models, all of which are using 10-fold repeated cross
# validation with 3 repeats:
#   LDA
#   CART
#   KNN
#   SVM
#   Random Forest

train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### LDA ----
set.seed(7)
diabetes_model_lda <- train(Type ~ ., data = Glass,
                            method = "lda", trControl = train_control)

### CART ----
set.seed(7)
diabetes_model_cart <- train(Type ~ ., data = Glass,
                             method = "rpart", trControl = train_control)

### KNN ----
set.seed(7)
diabetes_model_knn <- train(Type ~ ., data = Glass,
                            method = "knn", trControl = train_control)

### SVM ----
set.seed(7)
diabetes_model_svm <- train(Type ~ ., data = Glass,
                            method = "svmRadial", trControl = train_control)

### Random Forest ----
set.seed(7)
diabetes_model_rf <- train(Type ~ ., data = Glass,
                           method = "rf", trControl = train_control)


## 3.b. Call the `resamples` Function ----
# We then create a list of the model results and pass the list as an argument
# to the `resamples` function.

results <- resamples(list(LDA = diabetes_model_lda, CART = diabetes_model_cart,
                          KNN = diabetes_model_knn, SVM = diabetes_model_svm,
                          RF = diabetes_model_rf))

# STEP 4. Display the Results ----
## 1. Table Summary ----
summary(results)

## 2. Box and Whisker Plot ----

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)

## 3. Dot Plots ----

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)

## 4. Scatter Plot Matrix ----
splom(results)



# xyplot plots to compare models
xyplot(results, models = c("LDA", "CART"))

# or
# xyplot plots to compare models
xyplot(results, models = c("SVM", "LDA"))

## 6. Statistical Significance Tests ----

diffs <- diff(results)

summary(diffs)
