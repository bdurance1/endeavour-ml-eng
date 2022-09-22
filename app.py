"""
TODO
"""

import dill
from flask import Flask, request
from flask import jsonify
import numpy as np
import app_utils
from log_manager.log_manager import app_logger
from constants.app import APP_NAME
from constants.model import MODEL_NAME

app = Flask(__name__)

with open('VERSION', 'r', encoding = "utf-8") as f:
    version = f.readline().rstrip()
app_logger.info(f"Starting service {APP_NAME}. Version {version}")

app_logger.info(f"Loading model {MODEL_NAME} from disk")
model_path = f"{MODEL_NAME}.sav"
with open(model_path, 'rb') as f:
    model_object = dill.load(f)

# @app.route('/', methods=['POST'])
# def app_run():


@app.route('/service', methods=['GET'])
def service():
    """Return service meta"""
    app_logger.info("API call: 'app'")
    result = {}
    result["name"] = APP_NAME
    result["version"] = version
    return result, 200


@app.route('/health', methods=['GET'])
def health():
    """Return service health"""
    app_logger.info("API call: 'health'")
    return 'ok', 200


@app.route('/model', methods=['GET'])
def model():
    """Return model meta"""
    app_logger.info("API call: 'model'")
    result = {}
    result["name"] = MODEL_NAME
    return result, 200


# A single route 'predict' can perform the requirement of the two proposed
# endpoints 'stream' and 'batch'.
@app.route('/predict', methods=['POST'])
def predict():
    """Recieve feature data, return predictions"""
    app_logger.info("API call: 'predict'")
    features = np.asarray(request.get_json())
    response = app_utils.predict(model_object.W, model_object.b, features.T)
    return jsonify(response.tolist()), 200


if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
