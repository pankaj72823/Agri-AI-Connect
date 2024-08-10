import wrapAsync from "../Utils/wrapAsync.js";
import jwt from "jsonwebtoken"
import Question  from "../Models/Question.js";
import Answer from "../Models/Answer.js";
import axios from "axios";
import { response } from "express";
const jwtSecret = process.env.jwtSecret

export const answers = wrapAsync(async (req, res) => {
    const { token, data } = req.body;
    let userId;

    // Verify token
    try {
        const decoded = jwt.verify(token, jwtSecret);
        userId = decoded.sub;
    } catch (err) {
        return res.status(401).send('Invalid token');
    }

    // Retrieve all questions in one query
    const questionTexts = data.map(userAnswer => userAnswer.question);
    const questions = await Question.find({ question: { $in: questionTexts } }).lean();

    // Create a map of question texts to their IDs
    const questionMap = questions.reduce((map, question) => {
        map[question.question] = question._id;
        return map;
    }, {});

    // Collect all responses
    const responses = data
        .filter(userAnswer => questionMap[userAnswer.question])
        .map(userAnswer => ({
            userId,
            questionId: questionMap[userAnswer.question],
            answer: userAnswer.answer
        }));

    // Bulk insert responses
    try {
        await Answer.insertMany(responses);
    } catch (error) {
        console.error('Error inserting responses:', error);
        return res.status(500).send('Error saving answers');
    }
    // return res.send("Done")
    // Call the result route
    const url = 'http://localhost:5050/answers/result';
    try {
        const response = await axios.post(url, { token });
        res.status(200).send(response.data);
    } catch (error) {
        console.error('Error calling the route:', error);
        res.status(500).send('Error retrieving results');
    }
});