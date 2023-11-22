async function ensureAuth(req, res, next) {
  const { authorized } = req.session;

  if (!authorized) {
    return res.redirect('/login');
  }

  next();
}

module.exports = ensureAuth;