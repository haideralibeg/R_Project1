# load libraries
library(tidyverse)    # package that supports the "tibble" data structure which is a dataframe
library(rpart)        # The PART classifier, not included in mlbench
library(rpart.plot)   # visualize the decision tree that is built
library(caret)
library(RWeka)        # RWeka provides access to the PART classifier
library(Rtsne)
library(FSelector)
library(lattice)


credit_data <- read.csv("C:/Users/haide/Documents/R_Project1/credit-g.csv", stringsAsFactors = TRUE) #

print(head(credit_data))


# Task 1: Data Preprocessing -

# Task 1.3 - Data preparation for t-SNE (numeric)
dummy_mod <- dummyVars("~ .", data = credit_data[, -21])
num_data <- predict(dummy_mod, newdata = credit_data[, -21])

# 1.3 cont. running t-SNE
set.seed(42)
tsne_out <- Rtsne(
  as.matrix(num_data),
  perplexity = 30,
  check_duplicates = FALSE
)

#plotting t-SNE
plot(
  tsne_out$Y,
  col = credit_data$class,
  pch = 19,
  main = "Task 1: t-SNE Visualization"
)

legend(
  "topright",
  legend = levels(credit_data$class),
  col = 1:2,
  pch = 19
)


# training 
set.seed(123)
in_train <- createDataPartition(
  y = credit_data$class,
  p = 0.7,
  list = FALSE
)

train_set <- credit_data[in_train, ]
test_set <- credit_data[-in_train, ]

# feature selection for training data
weights <- chi.squared(class ~., data = train_set)
selected_features <- cutoff.k(weights, 10)
f <- as.simple.formula(selected_features, "class")

print(f)

# Task 2 - Train Classifiers 

tr_ctrl <- trainControl(
  method = "repeatedcv",
  number = 10,
  repeats = 3
)

set.seed(3333)

# Task2 Part 1
dtree_fit <- train(
  f, 
  data = train_set,
  method = "rpart",
  trControl = tr_ctrl
)

part_fit <- train(
  f,
  data = train_set,
  method = "PART",
  trControl = tr_ctrl
)

ripper_fit <- train(
  f,
  data = train_set,
  method = "JRip",
  trControl = tr_ctrl
)

# Task2 part 2
# display rule
print(dtree_fit$finalModel)
print(part_fit$finalModel)
print(ripper_fit$finalModel)


# Task 3 - ANOVA & TUKEY test 

res <- resamples(
  list(
    decision_tree = dtree_fit,
    PART = part_fit,
    ripper = ripper_fit
  )
)

res_table <- res$values

vec_dtree <- res_table$`decision_tree~Accuracy`
vec_part <- res_table$`PART~Accuracy`
vec_ripper <- res_table$`ripper~Accuracy`

accuracy_vals <- c(vec_dtree, vec_part, vec_ripper)

model_labels <- c(
  rep("DecisionTree", 30),
  rep("PART", 30),
  rep("Ripper", 30)
)

anova_data <- data.frame(
  Accuracy = accuracy_vals,
  Model = model_labels
)

anova_res <- aov(Accuracy ~ Model, data = anova_data)

print(summary(anova_res))
print(TukeyHSD(anova_res))

lattice::bwplot(res, main = "Classifier Accuracy Comparison")


# Task 4 - adding noise

noisy_data <- credit_data

set.seed(999)
noise_index <- sample(1:nrow(noisy_data), 0.10 * nrow(noisy_data)) # 10% of rows

noisy_data$class[noise_index] <- ifelse(
  noisy_data$class[noise_index] == "good", "bad", "good"
)

# split data
set.seed(123)

inTrain_noise <- createDataPartition(
  y = noisy_data$class,
  p = 0.7,
  list = FALSE
)

training_noise <- noisy_data[inTrain_noise, ]
testing_noise <- noisy_data[-inTrain_noise, ]

print("Training noisy data...")


# feature selection for noisy data

weights_noise <- chi.squared(class ~ ., data = training_noise)
select_noise <- cutoff.k(weights_noise, 10)
f_noise <- as.simple.formula(select_noise, "class")

dtree_fit <- train(
  f_noise, 
  data = train_set,
  method = "rpart",
  trControl = tr_ctrl
)

part_fit <- train(
  f_noise,
  data = train_set,
  method = "PART",
  trControl = tr_ctrl
)

ripper_fit <- train(
  f_noise,
  data = train_set,
  method = "JRip",
  trControl = tr_ctrl
)

res_noise <- resamples(
  list(
    decision_tree = dtree_fit,
    PART = part_fit,
    ripper = ripper_fit
  )
)

res_table_noise <- res_noise$values

vec_dtree_noise <- res_table_noise$`decision_tree~Accuracy`
vec_part_noise <- res_table_noise$`PART~Accuracy`
vec_ripper_noise <- res_table_noise$`ripper~Accuracy`

accuracy_vals_noise <- c(vec_dtree_noise, vec_part_noise, vec_ripper_noise)

model_labels_noise <- c(
  rep("DecisionTree", 30),
  rep("PART", 30),
  rep("Ripper", 30)
)

anova_data_noise <- data.frame(
  Accuracy = accuracy_vals_noise,
  Model = model_labels_noise
)

anova_res_noise <- aov(Accuracy ~ Model, data = anova_data_noise)

print("---TASK 4 Results---")
print(summary(anova_res_noise))
print(TukeyHSD(anova_res_noise))
 












