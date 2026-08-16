# Customer Churn Prediction Analytics

An end-to-end customer churn prediction and analytics system built using Python, Machine Learning, SQL, and Streamlit.

## Project Overview

Customer churn is an important business problem because losing existing customers can directly affect revenue and growth.

This project analyzes customer data to identify factors associated with churn, performs exploratory data analysis and feature engineering, trains multiple machine learning classification models, evaluates their performance, and provides an interactive Streamlit application for predicting the probability and risk level of customer churn.

## Objectives

- Analyze customer churn patterns
- Clean and preprocess customer data
- Perform exploratory data analysis (EDA)
- Engineer features for machine learning
- Train and compare classification models
- Evaluate models using multiple performance metrics
- Optimize the churn classification threshold
- Perform SQL-based business analysis
- Build an interactive customer churn prediction application

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Scikit-learn
- SQL / MySQL
- Streamlit
- Joblib
- Jupyter Notebook
- Git & GitHub

## Machine Learning Workflow

```text
Raw Customer Data
        ↓
Data Cleaning
        ↓
Exploratory Data Analysis
        ↓
Feature Engineering
        ↓
Train/Test Split
        ↓
Data Preprocessing
        ↓
Model Training
        ↓
Model Evaluation
        ↓
Threshold Optimization
        ↓
Customer Churn Prediction
        ↓
Streamlit Application
```
## Dataset

The project uses a customer churn dataset containing customer demographic, service, contract, payment, tenure, and billing information.

The target variable is:

Churn = Yes → Customer churned
Churn = No → Customer retained

The dataset contains 7,043 customers.

## Data Preprocessing

The preprocessing pipeline includes:

- Numerical feature scaling using StandardScaler
- Categorical feature encoding using OneHotEncoder
- Column-wise preprocessing using ColumnTransformer

The processed dataset contains 45 features.

The data was split into:

Training data: 5,634 records
Testing data: 1,409 records

The churn distribution was approximately:

Class	       Percentage
No Churn	73.46%
Churn	        26.53%

## Machine Learning Models
Three classification models were trained and evaluated:

- Logistic Regression
- Decision Tree
- Random Forest

The models were evaluated using:

- Accuracy
- Precision
- Recall
- F1-score
- ROC-AUC
- Confusion Matrix

## Logistic Regression

The Logistic Regression model achieved approximately:
- Accuracy: 80.55%
- Recall: 55.88%
- ROC-AUC: 84.21%

The confusion matrix showed the model's performance in distinguishing customers who churned from customers who stayed.


