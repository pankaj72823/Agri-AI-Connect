import User from "../Models/User.js"
import jwt from 'jsonwebtoken'
import wrapAsync from "../Utils/wrapAsync.js"

const jwtSecret = process.env.jwtSecret

export const signup =wrapAsync( async(req,res)=>{
    const {username}=req.body
    const existingUser = await User.findOne({username})
    if(existingUser){
        return res.status(400).json({message:`User Already Exists`})
    }
   
    const newUser = new User(req.body)

    const regUser = await newUser.save();
    const token = jwt.sign({ sub: regUser._id }, jwtSecret, { expiresIn: '1d' });
    res.status(200).json({ token}); 
  }
)

export const login = wrapAsync(async(req,res)=>{
    const {username, password} =req.body
    const user = await User.findOne({username})
    if(!user){
        return res.status(401).json({ message: 'Invalid username or password' });
    }
    user.comparePassword(password, (err, isMatch) => {
        if (err) return res.status(500).json({ message: 'Internal server error' });
        if (!isMatch) return res.status(401).json({ message: 'Invalid username or password' });

        const token = jwt.sign({ sub: user._id }, jwtSecret, { expiresIn: '1d' });
        res.status(200).json({token});
      });
})