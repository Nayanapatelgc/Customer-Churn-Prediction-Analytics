from predict import predict_churn


customer = {
    "gender": "Female",
    "SeniorCitizen": 0,
    "Partner": "No",
    "Dependents": "No",
    "tenure": 5,
    "PhoneService": "Yes",
    "MultipleLines": "No",
    "InternetService": "Fiber optic",
    "OnlineSecurity": "No",
    "OnlineBackup": "No",
    "DeviceProtection": "No",
    "TechSupport": "No",
    "StreamingTV": "Yes",
    "StreamingMovies": "Yes",
    "Contract": "Month-to-month",
    "PaperlessBilling": "Yes",
    "PaymentMethod": "Electronic check",
    "MonthlyCharges": 90.0,
    "TotalCharges": 450.0
}

result = predict_churn(customer)

print("Prediction Result")
print("-----------------------")
print("Churn Probability:",
      round(result["churn_probability"] * 100, 2), "%")

print("Prediction:",
      "Churn" if result["prediction"] == 1
      else "No Churn")

print("Risk Level:",
      result["risk_level"])
