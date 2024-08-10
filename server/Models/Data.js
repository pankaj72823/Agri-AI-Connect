import mongoose from "mongoose";

const Schema = mongoose.Schema;

const dataSchema = new mongoose.Schema({
    farmer_id: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    acers_of_land: {
        type: Number,
        required: true,
    },
    location_of_field: {
        type: String,
        required: true
    },
    types_of_crops: [{
        type: String,
        required: true
    }],
    maximum_crops: {
        type: String,
        required: true
    }

});

const Data = new mongoose.model('Data', dataSchema);

export default Data;
