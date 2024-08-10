from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import cv2

app = Flask(__name__)

# Load your model
model = tf.keras.models.load_model('amanking.h5')

@app.route('/')
def home():
    return "Welcome to the Plant Disease Prediction API! Use the /predict endpoint to make predictions."

@app.route('/predict', methods=['POST'])

def predict():
    print("hello")
    file = request.files['image']
    # Read the file as an image
    img = cv2.imdecode(np.fromstring(file.read(), np.uint8), cv2.IMREAD_COLOR)
    img = cv2.resize(img, (100, 100))
    img = img.astype("float32") / 255.0  # Normalize the image
    img = np.expand_dims(img, axis=0)  # Add batch dimension

    # Make prediction
    prediction = model.predict(img)
    predicted_class_index = np.argmax(prediction[0])

    # Class names
    class_name = ['Apple__Apple_scab', 'Apple_Black_rot', 'Apple_Cedar_apple_rust', 'Apple__healthy',
                    'Blueberry__healthy', 'Cherry(including_sour)_Powdery_mildew', 
                    'Cherry_(including_sour)healthy', 'Corn(maize)_Cercospora_leaf_spot Gray_leaf_spot', 
                    'Corn_(maize)Common_rust', 'Corn_(maize)Northern_Leaf_Blight', 'Corn(maize)_healthy', 
                    'Grape__Black_rot', 'Grape_Esca(Black_Measles)', 'Grape__Leaf_blight(Isariopsis_Leaf_Spot)', 
                    'Grape__healthy', 'Orange_Haunglongbing(Citrus_greening)', 'Peach___Bacterial_spot',
                    'Peach__healthy', 'Pepper,_bell_Bacterial_spot', 'Pepper,_bell__healthy', 
                    'Potato___Early_blight']

    return jsonify({'predicted_class': class_name[predicted_class_index]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
