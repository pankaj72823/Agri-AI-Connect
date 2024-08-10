import { Schema, model } from 'mongoose';

// Define the schema
const questionSchema = new Schema({
  question: {
    type: String,
    required: true
  },
  type: {
    type: String,
    enum: ['multiple_choice', 'single_choice', 'boolean', 'number'],
    required: true
  },
  options: {
    type: [String], // Array of strings for options
    default: []
  },
  category: {
    type: String,
    required: true
  },
}); // Automatically add createdAt and updatedAt fields

// Create the model
const Question = model('Question', questionSchema);

export default Question;
