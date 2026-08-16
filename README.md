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

## Churn Threshold Optimization

Instead of relying only on the default classification threshold of 0.50, different thresholds were tested.

The project evaluated thresholds from 0.30 to 0.55.

Example results:

Threshold	Precision	Recall	        F1 Score
0.30	        0.519	        0.754	        0.615
0.35	        0.543	        0.706	        0.614
0.40	        0.568	        0.668	        0.614
0.45	        0.602	        0.614	        0.608
0.50	        0.657	        0.559	        0.604
0.55	        0.678	        0.463	        0.551

A threshold of 0.40 was selected for the prediction application to identify more potential churn customers.

## SQL Business Analysis

SQL was used to analyze customer churn from a business perspective.

## Overall Churn
- Total customers: 7,043
- Churned customers: 1,869
- Retained customers: 5,174
- Overall churn rate: 26.54%

## Churn by Contract

Month-to-month customers showed substantially higher churn than customers with one-year or two-year contracts.

Contract	Churn Rate
Month-to-month	42.71%
One year	11.27%
Two year	2.83%

## Churn by Internet Service

Internet Service	Churn Rate
Fiber optic	        41.89%
DSL	                18.96%
No internet service	7.40%

## Churn by Payment Method

Electronic check customers showed the highest churn rate.

Payment Method	                Churn Rate
Electronic check	        45.29%
Mailed check	                19.11%
Bank transfer (automatic)	16.71%
Credit card (automatic)	        15.24%

##Churn by Tenure

Customers with shorter tenure showed considerably higher churn.

Tenure Group	Churn Rate
0–12 Months	47.44%
13–24 Months	28.71%
25–48 Months	20.39%
49–72 Months	9.51%

##Churn by Risk Level

The project categorizes customers into Low, Medium, and High risk.

Risk Level	Customers	Churn Rate
High Risk	1,542	        62.71%
Medium Risk	2,298	        30.77%
Low Risk	3,203	        6.09%

This shows that the risk classification provides a useful way to prioritize customers for retention strategies.

## Streamlit Application

The project includes an interactive Streamlit application where users can enter customer information such as:

- Gender
- Senior citizen status
- Tenure
- Monthly charges
- Total charges
- Phone service
- Internet service
- Online security
- Device protection
- Tech support
- Streaming services
- Contract
- Payment method
- Paperless billing

The application returns:

- Churn probability
- Churn prediction
- Risk level
- Retention recommendation

##Example Prediction
The application can produce results such as:
Churn Probability: 72.84%
Prediction: Churn
Risk Level: High

# or:
Churn Probability: 1.54%
Prediction: Stay
Risk Level: Low

## Project Structure
Customer-Churn-Prediction-Analytics/
│
├── app/
│   └── app.py
│
├── data/
│   ├── raw/
│   │   └── customer_churn.csv
│   │
│   └── processed/
│       ├── cleaned_customer_churn.csv
│       ├── churn_predictions.csv
│       └── feature_importance.csv
│
├── models/
│   ├── churn_model.pkl
│   └── preprocessor.pkl
│
├── notebooks/
│   ├── 01_data_understanding.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_eda.ipynb
│   ├── 04_feature_engineering.ipynb
│   ├── 05_model_training.ipynb
│   └── 06_model_evaluation.ipynb
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_Tables.sql
│   └── 03_analysis_queries.sql
│
├── src/
│   ├── predict.py
│   └── test_prediction.py
│
├── .gitignore
├── README.md
└── requirements.txt


