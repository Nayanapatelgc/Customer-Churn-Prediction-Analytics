import streamlit as st
import sys
from pathlib import Path

# Add src folder to Python path
BASE_DIR = Path(__file__).resolve().parent.parent
sys.path.append(str(BASE_DIR / "src"))

from predict import predict_churn


# --------------------------------------------------
# Page Configuration
# --------------------------------------------------

st.set_page_config(
    page_title="Customer Churn Prediction",
    page_icon="📊",
    layout="wide"
)


# --------------------------------------------------
# Title
# --------------------------------------------------

st.title("📊 Customer Churn Prediction")
st.write(
    "Enter customer details to predict the probability "
    "of customer churn."
)


# --------------------------------------------------
# Customer Information
# --------------------------------------------------

st.header("Customer Information")

col1, col2, col3 = st.columns(3)

with col1:
    gender = st.selectbox(
        "Gender",
        ["Female", "Male"]
    )

    senior_citizen = st.selectbox(
        "Senior Citizen",
        [0, 1]
    )

    partner = st.selectbox(
        "Partner",
        ["Yes", "No"]
    )

    dependents = st.selectbox(
        "Dependents",
        ["No", "Yes"]
    )

with col2:
    tenure = st.number_input(
        "Tenure (Months)",
        min_value=0,
        max_value=72,
        value=12
    )

    monthly_charges = st.number_input(
        "Monthly Charges",
        min_value=18.25,
        max_value=118.75,
        value=70.0
    )

    total_charges = st.number_input(
        "Total Charges",
        min_value=0.0,
        max_value=8884.8,
        value=1000.0
    )

with col3:
    phone_service = st.selectbox(
        "Phone Service",
        ["No", "Yes"]
    )

    multiple_lines = st.selectbox(
        "Multiple Lines",
        ["No phone service", "No", "Yes"]
    )

    internet_service = st.selectbox(
        "Internet Service",
        ["DSL", "Fiber optic", "No"]
    )


# --------------------------------------------------
# Services
# --------------------------------------------------

st.header("Internet Services")

col1, col2, col3 = st.columns(3)

with col1:
    online_security = st.selectbox(
        "Online Security",
        ["No", "Yes", "No internet service"]
    )

    online_backup = st.selectbox(
        "Online Backup",
        ["No", "Yes", "No internet service"]
    )

with col2:
    device_protection = st.selectbox(
        "Device Protection",
        ["No", "Yes", "No internet service"]
    )

    tech_support = st.selectbox(
        "Tech Support",
        ["No", "Yes", "No internet service"]
    )

with col3:
    streaming_tv = st.selectbox(
        "Streaming TV",
        ["No", "Yes", "No internet service"]
    )

    streaming_movies = st.selectbox(
        "Streaming Movies",
        ["No", "Yes", "No internet service"]
    )


# --------------------------------------------------
# Contract and Payment
# --------------------------------------------------

st.header("Contract & Payment Information")

col1, col2 = st.columns(2)

with col1:
    contract = st.selectbox(
        "Contract",
        ["Month-to-month", "One year", "Two year"]
    )

    paperless_billing = st.selectbox(
        "Paperless Billing",
        ["Yes", "No"]
    )

with col2:
    payment_method = st.selectbox(
        "Payment Method",
        [
            "Electronic check",
            "Mailed check",
            "Bank transfer (automatic)",
            "Credit card (automatic)"
        ]
    )


# --------------------------------------------------
# Prediction Button
# --------------------------------------------------

st.divider()

if st.button(
    "🔮 Predict Customer Churn",
    use_container_width=True
):

    customer_data = {
        "gender": gender,
        "SeniorCitizen": senior_citizen,
        "Partner": partner,
        "Dependents": dependents,
        "tenure": tenure,
        "PhoneService": phone_service,
        "MultipleLines": multiple_lines,
        "InternetService": internet_service,
        "OnlineSecurity": online_security,
        "OnlineBackup": online_backup,
        "DeviceProtection": device_protection,
        "TechSupport": tech_support,
        "StreamingTV": streaming_tv,
        "StreamingMovies": streaming_movies,
        "Contract": contract,
        "PaperlessBilling": paperless_billing,
        "PaymentMethod": payment_method,
        "MonthlyCharges": monthly_charges,
        "TotalCharges": total_charges
    }

    try:

        result = predict_churn(customer_data)

        probability = result["churn_probability"]
        prediction = result["prediction"]
        risk_level = result["risk_level"]

        st.subheader("Prediction Result")

        col1, col2, col3 = st.columns(3)

        with col1:
            st.metric(
                "Churn Probability",
                f"{probability * 100:.2f}%"
            )

        with col2:

            if prediction == 1:
                st.error("⚠️ Customer likely to Churn")
            else:
                st.success("✅ Customer likely to Stay")

        with col3:

            if risk_level == "High":
                st.error("🔴 High Risk")
            elif risk_level == "Medium":
                st.warning("🟠 Medium Risk")
            else:
                st.success("🟢 Low Risk")

        st.progress(float(probability))

        st.write(
            f"**Risk Level:** {risk_level}"
        )

        if prediction == 1:
            st.warning(
                "This customer has a high likelihood of churning. "
                "Consider retention strategies such as discounts, "
                "personalized offers, or improved support."
            )
        else:
            st.success(
                "This customer is currently predicted to stay."
            )

    except Exception as e:

        st.error(
            f"Prediction failed: {e}"
        )