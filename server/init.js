import { questions } from "./Utils/dummyData.js"
import './config/mongodb.js'
import Question from "./Models/Question.js"
const startup =async()=>{
    
    await Question.insertMany(questions)

    console.log("intialization Completed")
}

startup()