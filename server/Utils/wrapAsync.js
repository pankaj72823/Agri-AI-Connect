const wrapAsync = (fn) => {
    return (req, res, next) => {
      Promise.resolve(fn(req, res, next))
        .catch(next);  // Pass any error to Express's default error handler
    };
  };
  
export default wrapAsync;
  