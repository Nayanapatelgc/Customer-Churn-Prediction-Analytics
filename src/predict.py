from pathlib import Path
import pandas as pd
import joblib


BASE_DIR = Path(__file__).resolve().parent.parent

model = joblib.load(
    BASE_DIR / "models" / "churn_model.pkl"
)

preprocessor = joblib.load(
    BASE_DIR / "models" / "preprocessor.pkl"
)

CHURN_THRESHOLD = 0.40


def predict_churn(customer_data):

    customer_df = pd.DataFrame([customer_data])

    processed_data = preprocessor.transform(
        customer_df
    )

    probability = model.predict_proba(
        processed_data
    )[0][1]

    prediction = int(
        probability >= CHURN_THRESHOLD
    )

    if probability < 0.30:
        risk_level = "Low"
    elif probability < 0.70:
        risk_level = "Medium"
    else:
        risk_level = "High"

    return {
        "churn_probability": probability,
        "prediction": prediction,
        "risk_level": risk_level
    }