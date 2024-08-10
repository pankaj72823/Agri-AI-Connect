import express from 'express'
import { answers } from '../Controllers/answersController.js'
import { result } from '../Controllers/resultController.js'
const router = express.Router()

router.post('/',answers)

router.post('/result',result)

export {router as answersRouter}