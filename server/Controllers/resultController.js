import { genAI } from '../config/genAI.js';
import express from 'express'
import readline from 'readline';
import wrapAsync from "../Utils/wrapAsync.js";
import jwt from "jsonwebtoken"
import  Answer  from "../Models/Answer.js";
import User from '../Models/User.js';
const jwtSecret = "EcoCred#Carbon@X"


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
                const message = `I will provide you with JSON data containing various categories. Your task is to calculate the carbon credits for each category based on this data and predefined reduction factors. Also, provide only 3 suggestions for improvements. The result should be as accurate as possible, but an approximate value is acceptable. Ensure that your response is formatted according to the structure provided in the following format: ${JSON.stringify(format)} and no string allowed as an answer. Write the answer in numbers with the unit in tons of CO2. Here is the JSON data: ${JSON.stringify(data)}.`
                const result = await chat.sendMessage(message);
                const response = await result.response
                const text = response.text();
                return extractAllCurlyBracesSubstrings(text);
            }

    return await askAndRespond();
}

const format = 
{
    "Crop Management": 0.9,
    "Soil Management": 0.15,
    "Water Usage": 0.2,
    "Energy Use": 1.5,
    "Waste Management": 0.3,
    "totalCarbonCredits": 2.35
  }
  


export const result = wrapAsync(async(req,res)=>{
    const {token} = req.body
    let userId;
    jwt.verify(token, jwtSecret, (err, decoded) => {
        if (err) {
            return res.status(401).send('Invalid token');
        }
        else{
            userId = decoded.sub
        }
    })
    const answers = await Answer.find({ userId }).populate('questionId').exec();
    let detailAnswere=[]
    for (const answer of answers) {
        detailAnswere.push({
            category : answer.questionId.category,
            question : answer.questionId.question,
            answer : answer.answer
        })
    }
    const result =await run(detailAnswere)
    let currentTimestamp = Date.now();
    let currentDate = new Date(currentTimestamp);
    console.log(result)
    const updatedCarbonFootprint = {
        'carbon_credits.Crop_Management': result.Crop_Management,
        'carbon_credits.Soil_Management': result.Soil_Management,
        'carbon_credits.Water_Usage': result.Water_Usage,
        'carbon_credits.Energy_Use': result.Energy_Use,
        'carbon_credits.Waste_Management': result.Waste_Management,
        'carbon_credits.total': result.total,
        'carbon_credits.suggestions': result.suggestions,
        'carbon_credits.last_tracked': currentDate.toLocaleString()
      };
      console.log(updatedCarbonFootprint)
    const updatedUser = await User.updateOne({ _id: userId }, { $set: updatedCarbonFootprint });
    res.status(200).send(result)
})