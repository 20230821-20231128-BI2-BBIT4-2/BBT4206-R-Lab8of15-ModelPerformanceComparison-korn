Business Intelligence Project
================
korn
5/11/23

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Lab 8.: Model Performance
  Comparison](#lab-8-model-performance-comparison)
  - [STEP 1. Install and Load the Required
    Packages](#step-1-install-and-load-the-required-packages)
  - [STEP 2. Load the Dataset](#step-2-load-the-dataset)
  - [STEP 3. The Resamples Function](#step-3-the-resamples-function)
    - [3.b. Call the `resamples` Function
      —-](#3b-call-the-resamples-function--)
  - [STEP 4. Display the Results](#step-4-display-the-results)

# Student Details

<table style="width:85%;">
<colgroup>
<col style="width: 45%" />
<col style="width: 38%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Numbers and Names of Group Members</strong></td>
<td><ol type="1">
<li><p>134644 - C - Sebastian Muramara</p></li>
<li><p>136675 - C - Bernard Otieno</p></li>
<li><p>131589 - C - Agnes Anyango</p></li>
<li><p>131582 - C - Njeri Njuguna</p></li>
<li><p>136009 - C- Sera Ndabari</p></li>
</ol></td>
</tr>
<tr class="even">
<td><strong>GitHub Classroom Group Name</strong></td>
<td>Korn</td>
</tr>
<tr class="odd">
<td><strong>Course Code</strong></td>
<td>BBT4206</td>
</tr>
<tr class="even">
<td><strong>Course Name</strong></td>
<td>Business Intelligence II</td>
</tr>
<tr class="odd">
<td><strong>Program</strong></td>
<td>Bachelor of Business Information Technology</td>
</tr>
<tr class="even">
<td><strong>Semester Duration</strong></td>
<td>21<sup>st</sup> August 2023 to 28<sup>th</sup> November 2023</td>
</tr>
</tbody>
</table>

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# Lab 8.: Model Performance Comparison

## STEP 1. Install and Load the Required Packages

``` r
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: mlbench

``` r
## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: caret

    ## Loading required package: ggplot2

    ## Loading required package: lattice

``` r
## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: kernlab

    ## 
    ## Attaching package: 'kernlab'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     alpha

``` r
## randomForest ----
if (require("randomForest")) {
  require("randomForest")
} else {
  install.packages("randomForest", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: randomForest

    ## randomForest 4.7-1.1

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

## STEP 2. Load the Dataset

``` r
data(Glass)
```

## STEP 3. The Resamples Function

``` r
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
```

### 3.b. Call the `resamples` Function —-

``` r
results <- resamples(list(LDA = diabetes_model_lda, CART = diabetes_model_cart,
                          KNN = diabetes_model_knn, SVM = diabetes_model_svm,
                          RF = diabetes_model_rf))
```

## STEP 4. Display the Results

``` r
## 1. Table Summary ----
summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: LDA, CART, KNN, SVM, RF 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## LDA  0.3636364 0.5454545 0.6277056 0.6212071 0.6916667 0.9047619    0
    ## CART 0.4545455 0.6190476 0.6363636 0.6493475 0.7142857 0.8181818    0
    ## KNN  0.3809524 0.6190476 0.6742424 0.6672596 0.7443182 0.9047619    0
    ## SVM  0.4761905 0.6363636 0.6666667 0.6783581 0.7142857 0.8571429    0
    ## RF   0.6521739 0.7727273 0.8095238 0.7995313 0.8420455 0.9090909    0
    ## 
    ## Kappa 
    ##           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## LDA  0.1561644 0.3659318 0.4813037 0.4706998 0.5636423 0.8636364    0
    ## CART 0.1975684 0.4421330 0.4962492 0.4978139 0.5775276 0.7341390    0
    ## KNN  0.1574074 0.4631516 0.5446795 0.5395413 0.6337050 0.8707692    0
    ## SVM  0.2300000 0.4743722 0.5234895 0.5362700 0.5971656 0.7980769    0
    ## RF   0.5183246 0.6820494 0.7345965 0.7215597 0.7735402 0.8770950    0

``` r
## 2. Box and Whisker Plot ----

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)
```

![](Lab-Submission-Markdown_files/figure-gfm/STEP%204-1.png)<!-- -->

``` r
## 3. Dot Plots ----

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)
```

![](Lab-Submission-Markdown_files/figure-gfm/STEP%204-2.png)<!-- -->

``` r
## 4. Scatter Plot Matrix ----
splom(results)
```

![](Lab-Submission-Markdown_files/figure-gfm/STEP%204-3.png)<!-- -->

``` r
# xyplot plots to compare models
xyplot(results, models = c("LDA", "CART"))
```

![](Lab-Submission-Markdown_files/figure-gfm/STEP%204-4.png)<!-- -->

``` r
# or
# xyplot plots to compare models
xyplot(results, models = c("SVM", "LDA"))
```

![](Lab-Submission-Markdown_files/figure-gfm/STEP%204-5.png)<!-- -->

``` r
## 6. Statistical Significance Tests ----

diffs <- diff(results)

summary(diffs)
```

    ## 
    ## Call:
    ## summary.diff.resamples(object = diffs)
    ## 
    ## p-value adjustment: bonferroni 
    ## Upper diagonal: estimates of the difference
    ## Lower diagonal: p-value for H0: difference = 0
    ## 
    ## Accuracy 
    ##      LDA       CART      KNN       SVM       RF      
    ## LDA            -0.02814  -0.04605  -0.05715  -0.17832
    ## CART 1.00000             -0.01791  -0.02901  -0.15018
    ## KNN  0.64749   1.00000             -0.01110  -0.13227
    ## SVM  0.05278   0.74818   1.00000             -0.12117
    ## RF   2.810e-11 1.632e-09 5.278e-07 9.582e-12         
    ## 
    ## Kappa 
    ##      LDA       CART      KNN       SVM       RF       
    ## LDA            -0.027114 -0.068842 -0.065570 -0.250860
    ## CART 1.0000              -0.041727 -0.038456 -0.223746
    ## KNN  0.5062    1.0000               0.003271 -0.182018
    ## SVM  0.1861    1.0000    1.0000              -0.185290
    ## RF   1.609e-11 8.925e-10 5.647e-07 1.470e-12
