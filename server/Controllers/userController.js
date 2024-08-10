import jwt from "jsonwebtoken";
import User from "../Models/User.js";
import wrapAsync from "../Utils/wrapAsync.js";
import dotenv from 'dotenv';
dotenv.config();

const jwtSecret = process.env.jwtSecret

export const user = wrapAsync(async (req, res) => {
    const token = req.body.token;
    let userId;
    jwt.verify(token, jwtSecret, async (err, decoded) => {
        if (err) {
            return res.status(401).send('Invalid token');
        } else {
            userId = decoded.sub;
            const profile = await User.findById(userId).select('-_id -__v -password -gender -email');;
            return res.send(profile)
        }
    });
});
