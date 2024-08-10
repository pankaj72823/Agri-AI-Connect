import dotenv from 'dotenv';
import multer from 'multer';
import {spawn} from 'child_process'
dotenv.config();

import express from 'express'
import './config/multer.js'
import './config/passport.js'
import './config/mongodb.js'

import { authRouter } from './Router/authRouter.js';
import { uploadRouter } from './Router/uploadRouter.js';
import { questionRouter } from './Router/quetionRouter.js';
import { answersRouter } from './Router/answersRouter.js';
import { userRouter } from './Router/userRouter.js';
import { dataRouter } from './Router/dataRouter.js';

const app = express();
app.use(express.urlencoded({ extended: true }))
app.use(express.json())
const PORT = 5050;

app.use((req, res, next) => {
  const Logtime = new Date(Date.now());
  if(req.path != "/appIcon.ico"){
  console.log(
    `Method : ${req.method} \n Path : ${req.path} \n Time : ${Logtime} \n`
  )}
  next();
});
  

app.use('/auth' ,authRouter)
app.use('/upload', uploadRouter)
app.use('/question',questionRouter)
app.use('/answers',answersRouter)
app.use('/user',userRouter)
app.use('/data',dataRouter)
app.get('/',(req,res)=>{
    res.send("hello")
})


app.listen(PORT, () => {
    console.log(`Click to Connect : http://localhost:${PORT}/`);
});