const User = require("../model/User");

async function goToProfilePage(req, res) {
  const { user } = req.session;

  return res.render("profile.html", { user });
}

async function signUpUser(req, res) {
  let user = req.body;

  try {
    await User.create(user);

    res.render("login.html", {
      success: { message: "Usuário cadastrado com sucesso!" },
    });
  } catch (err) {
    console.log(err);

    res.render("sign-up.html", {
      error: { message: "Erro interno do servidor!" },
    });
  }
}

async function goToSignUpPage(req, res) {
  if (req.session.authorized) return res.redirect('/home');
  
  return res.render("sign-up.html");
}

async function goToLoginPage(req, res) {
  if (req.session.authorized) return res.redirect('/home');

  return res.render("login.html");
}

async function login(req, res) {
  const { email, password: requestPassword } = req.body;

  const userByEmail = await User.findOne({ where: { email } });

  if (!userByEmail) {
    res.render("login.html", {
      error: { message: "Email ou senha inválidos!" },
    });
    return;
  }

  const { password } = userByEmail;

  if (requestPassword !== password) {
    res.render("login.html", {
      error: { message: "Email ou senha inválidos!" },
    });
    return;
  }

  req.session.user = userByEmail;
  req.session.authorized = true;

  return res.redirect("/home");
}

async function updateUser(req, res) {
  const { id } = req.session.user;
  const data = req.body;

  try {
    await User.update(data, {
      where: { id: Number(id) },
    });

    const userUpdated = await User.findOne({ where: { id: Number(id) } });

    req.session.user = userUpdated;

    return res.render('profile.html', { success: { message: 'Informações atualizadas com sucesso!' } });
  } catch (err) {
    console.log(err);

    return res.render('profile.html', { error: { message: 'Erro interno do servidor' } });
  }
}

async function logout(req, res) {
  req.session.destroy();

  return res.redirect('/home');
}

module.exports = {
  signUpUser,
  goToSignUpPage,
  goToLoginPage,
  login,
  goToProfilePage,
  updateUser,
  logout,
};
