import mongoose from "mongoose";
const Schema = mongoose.Schema;

const answerSchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    questionId: { type: Schema.Types.ObjectId, ref: 'Question', required: true },
    answer: { type: Schema.Types.Mixed, required: true }
  });

const Answer =new mongoose.model('Answer', answerSchema);

export default Answer 