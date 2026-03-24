# R_Project1
This project consists of two milestones, with each having its deadline for submission.
Milestone 2 is a continuation of Milestone 1 and uses the same dataset which is the German
credit dataset. This dataset should be accessed from the download link in the Module 2 folder
and nowhere else as there are several different versions of this dataset and it is essential that
you use the version that is given.
One of the major characteristics of this dataset is the relatively larger number of predictor
features when compared to the datasets discussed in the lectures.
The project needs to be undertaken individually (not group work) and all code must be written
in the R language.
Task 1
Apply suitable data pre-processing operations on the data:
1. Identify in your report (not just in your R code) what pre-processing operations
you performed. Justify the list of preprocessing operations that you have
chosen. For each operation, write at least two sentences that argue why such
an operation is necessary. (5 points)
2. Produce R code in RStudio that implements these pre-processing operations.
(10 points)
3. Produce R code that visualize the class distribution of samples using the T-
distributed Stochastic Neighbor Embedding (tsne) visualization method. The
tsne method projects high dimensional data to a lower dimensional plane (2
dimensions) while preserving the spatial distribution of classes. For a tutorial
on the use of tsne see tsne in R - Search for details.
What insights can you gain from the tsne plot about the difficulty (or ease) of
classifying this dataset? Explain your answer. (15 points)
Task 2
1. Deploy the Decision Tree, PART and Ripper classifiers on your preprocessed
dataset to generate models on the Spambase dataset. Produce the R code
needed for this requirement under the heading “Task 2” part 1”
(10 points)
2. From the models generated in Task 1 part 1 above, produce rule bases for
each of your classifiers. Save these rule bases into your pdf report document
and present them under the heading “Task 2 part 2”, along with your R code.
(5 points)
Task 3
In this task we will use 10-fold cross validation (cv) with 3 repeats to obtain an accurate
assessment of a classifier’s accuracy. The cv strategy takes into account variation of
data across a dataset and is a more reliable assessment of accuracy. Once all the
folds (30) are in place you will carry out an F test to compare the 3 types of classifiers.
Collect the accuracy values for the classifiers into 3 vectors from the 30 different folds.
Carry out an F test in R (One-way ANOVA | When and How to Use It (With Examples)
(scribbr.com) on the 3 vectors.
Results of the F test may reveal that the 3 classifiers have significantly different
accuracies at a 95% level of confidence or that they have no significant difference. If
the F test reveals a significant difference, then the next step would be to determine
which one of them has the highest accuracy. This can be done with the help of the
Tukey post hoc test, which is explained in the same website as the one given for the
one-way ANOVA.
1. Produce the R code for this task.
(25 points)
2. Copy and paste the ANOVA table into your pdf report.
(5 points)
3. Identify, which (if any) classifier has the highest accuracy if it happens that the
F test reveals that the 3 are significantly different (use the Tukey test here).
Note that this part is not needed if all 3 classifiers are flagged by the F test as
having the same level of accuracy.
(5 points)
For this submission, your R code should be clearly commented, and each task
should be labelled. Add print statements to your code to clearly demonstrate it
working. Your code should be able to run directly in RStudio without any
compilation errors or warnings. This task should not require any user input.
