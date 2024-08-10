import express from 'express'
import {user} from '../Controllers/userController.js'

const router = express.Router()

router.post('/', user)


export {router as userRouter}