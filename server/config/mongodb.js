import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();
const dbLink = process.env.DB

async function main() {
    await mongoose.connect(dbLink);
  }
  main()
    .then((res) => {
      console.log("Connected to Database ");
    })
    .catch((err) => {
      console.log(err);
});