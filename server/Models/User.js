import mongoose from "mongoose";
import bcrypt from 'bcryptjs'
const Schema = mongoose.Schema;

const userSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    phone_number: {
        type: Number,
        required: true
    },
    username: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    gender: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    pincode: {
        type: String,
        required: true,
    },
    currentCrop: [{
        type: String,
        required: true
    }],
    carbon_credits: {
        Crop_Management: {
            type: Number,
            default: 0
        },
        Soil_Management: {
            type: Number,
            default: 0
        },
        Water_Usage: {
            type: Number,
            default: 0
        },
        Energy_Use: {
            type: Number,
            default: 0
        },
        Waste_Management: {
            type: Number,
            default: 0
        },
        total: {
            type: Number,
            default: 0
        },
        suggestions: {
            type: [String],
            default: null
        },
        last_tracked : {
            type : String,
            default : Date.now()
        }
    }
});

userSchema.pre('save', function (next) {
    if (!this.isModified('password')) return next();

    bcrypt.hash(this.password, 10, (err, hashedPassword) => {
        if (err) return next(err);
        this.password = hashedPassword;
        next();
    });
});

userSchema.methods.comparePassword = function (candidatePassword, cb) {
    bcrypt.compare(candidatePassword, this.password, (err, isMatch) => {
        if (err) return cb(err);
        cb(null, isMatch);
    });
};

const User = new mongoose.model("User", userSchema)

export default User