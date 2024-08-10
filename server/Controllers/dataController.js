import Data from "../Models/Data.js";
import wrapAsync from "../Utils/wrapAsync.js";
import jwt from 'jsonwebtoken'
const jwtSecret = process.env.jwtSecret
export const data = wrapAsync(async(req,res)=>{
    const token = req.body.token;
    let userId;
    jwt.verify(token, jwtSecret, async (err, decoded) => {
        if (err) {
            return res.status(401).send('Invalid token');
        } else {
            userId = decoded.sub;
        }
    });
    req.body.farmer_id = userId
    delete req.body.token;
    console.log(req.body)
    const data = new Data(req.body);
    await data.save();
    res.send(data)
})