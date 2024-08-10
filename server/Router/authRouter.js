import express from 'express'
import { signup,login } from '../Controllers/authController.js'

const router = express.Router()

router.post('/signup', signup)
router.post('/login', login)



export {router as authRouter}