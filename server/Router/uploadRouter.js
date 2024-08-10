import express from 'express'
import multer from 'multer';
import upload from '../config/multer.js';
import axios from 'axios';
import FormData from 'form-data';
import { createReadStream } from 'fs';
import { genAI } from '../config/genAI.js';
import readline from 'readline';



const router = express.Router();

const r1 = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
})


function extractAllCurlyBracesSubstrings(inputString) { 
    const startIndex = inputString.indexOf('{');
    const endIndex = inputString.lastIndexOf('}') + 1;
    const jsonString = inputString.substring(startIndex, endIndex);
    
    try {
        const jsonData = JSON.parse(jsonString);
        return jsonData
    } catch (error) {
        return JSON.parse('{"message" :"error" }');
    }
}

async function run(data){
    const model = genAI.getGenerativeModel({model: "gemini-1.5-flash"});
    const chat = model.startChat({
        history:[{
            role : 'user',
            parts : [{text : "Please provide your responses in JSON format only. Ensure the JSON is well-formed and includes the necessary fields. For example, if asked about a topic, respond with a JSON object that includes fields such as 'response' and 'details'"}]
        }],
        generationConfig : {
            maxOutputTokens: 100000,
        }   
    })
    async function askAndRespond(){
                const message = `Given a crop disease name : ${data}, generate a detailed JSON response with the following sections: disease (name of the disease), symptoms (list of symptoms), cure (steps to cure or manage the disease), pesticide (recommended pesticide name and application method), fertilizer (recommended fertilizer name and application method), and suggestions (additional tips for prevention or management). Provide the information in a structured JSON format. Here is the JSON format ${JSON.stringify(format)}.`
                const result = await chat.sendMessage(message);
                const response = await result.response
                const text = response.text();
                return extractAllCurlyBracesSubstrings(text);
            }

    return await askAndRespond();
}

const format = 
{
    "disease": "<Disease Name>",
    "symptoms": [
      "<Symptom 1>",
      "<Symptom 2>",
      "<Symptom 3>"
    ],
    "cure": [
      "<Cure Step 1>",
      "<Cure Step 2>",
      "<Cure Step 3>"
    ],
    "pesticide": {
      "name": "<Pesticide Name>",
      "application": "<Application Method>"
    },
    "fertilizer": {
      "name": "<Fertilizer Name>",
      "application": "<Application Method>"
    },
    "suggestions": [
      "<Suggestion 1>",
      "<Suggestion 2>",
      "<Suggestion 3>"
    ]
  }
  
async function predictImage(imagePath) {
    const form = new FormData();
    form.append('image', createReadStream(imagePath));
    console.log("sent")
    try {
        // Send POST request to the Flask API
        const response = await axios.post('http://127.0.0.1:8000/predict', form, {
            headers: {
                ...form.getHeaders()
            }
        });

        // Handle the response
        console.log('Predicted Class:', response.data.predicted_class);
        return response.data.predicted_class
    } catch (error) {
        console.error('Error during prediction:', error.response ? error.response.data : error.message);
    }
}

router.post('/',upload.single('file'),async(req,res)=>{
    const filePath = req.file.path;
    console.log(filePath)
    const disease =  await predictImage(filePath);
    // const disease = 'Apple scab'
    const result = await run(disease)
    res.send(result)
})

export {router as uploadRouter}