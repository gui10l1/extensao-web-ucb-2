const Product = require("../model/Product");

async function goToHomePage(req, res) {
  const { user } = req.session;
  const productId = req.query.id;

  const products = await Product.findAll();

  if (productId) {
    const productToEdit = await Product.findOne({ where: { id: productId } });

    return res.render("home.html", {
      user,
      products,
      edit: true,
      product: productToEdit,
    });
  }

  return res.render("home.html", { user, products });
}

async function createProduct(req, res) {
  const data = req.body;

  try {
    await Product.create(data);

    return res.redirect("/home");
  } catch (err) {
    return res.render("home.html", {
      error: { message: "Erro interno do servidor!" },
    });
  }
}

async function deleteProduct(req, res) {
  const { id } = req.params;

  try {
    await Product.destroy({
      where: {
        id: Number(id),
      },
    });

    return res.redirect("/home");
  } catch (err) {
    return res.render("home.html", {
      error: { message: "Erro interno do servidor!" },
    });
  }
}

async function updateProduct(req, res) {
  const { id } = req.params;
  const data = req.body;

  try {
    await Product.update(data, {
      where: { id: Number(id) },
    });

    return res.redirect('/home');
  } catch (err) {
    console.log(err);

    return res.render('home.html', { error: { message: 'Erro interno do servidor' } });
  }
}

module.exports = {
  goToHomePage,
  createProduct,
  deleteProduct,
  updateProduct,
};
