import multer, { diskStorage } from 'multer';
import { extname as _extname } from 'path';
import { storage } from './cloudConfig.js';

// const storage = diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, './uploads/');  
//   },
//   filename: (req, file, cb) => {
//     cb(null, file.fieldname + '-' + Date.now() + _extname(file.originalname));  
//   }
// });

// const fileFilter = (req, file, cb) => {

//   const fileTypes = /jpeg|jpg|png|gif/;
//   const extname = fileTypes.test(_extname(file.originalname).toLowerCase());
//   const mimetype = fileTypes.test(file.mimetype);

//   if (mimetype && extname) {
//     return cb(null, true);
//   } else {
//     cb('Error: Only images are allowed!');
//   }
// };

const limits = {
  fileSize: 1024 * 1024 * 50 
};


const upload = multer({
  storage: storage,
  // fileFilter: fileFilter,
  limits: limits
});

export default upload;
