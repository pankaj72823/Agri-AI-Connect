import express from 'express'
import {data} from '../Controllers/dataController.js'
const router = express.Router()

router.post('/',data)

export {router as dataRouter}