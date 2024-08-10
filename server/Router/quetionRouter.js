import express from 'express'
import wrapAsync from '../Utils/wrapAsync.js';
import Question from '../Models/Question.js';

const router = express.Router();

router.get('/',wrapAsync(async(req,res)=>{
    const questions = await Question.find().select('-_id -__v');
    res.status(200).send(questions)
}))

export {router as questionRouter}