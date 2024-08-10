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
    class_name =  [
    'Apple Apple scab',
    'Apple Black rot',
    'Apple Cedar apple rust',
    'Apple healthy',
    'Blueberry healthy',
    'Cherry (including sour) Powdery mildew',
    'Cherry (including sour) healthy',
    'Corn (maize) Cercospora leaf spot Gray leaf spot',
    'Corn (maize) Common rust',
    'Corn (maize) Northern Leaf Blight',
    'Corn (maize) healthy',
    'Grape Black rot',
    'Grape Esca (Black Measles)',
    'Grape Leaf blight (Isariopsis Leaf Spot)',
    'Grape healthy',
    'Orange Haunglongbing (Citrus greening)',
    'Peach Bacterial spot',
    'Peach healthy',
    'Pepper, bell Bacterial spot',
    'Pepper, bell healthy',
    'Potato Early blight'
]
    return jsonify({'predicted_class': class_name[predicted_class_index]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
