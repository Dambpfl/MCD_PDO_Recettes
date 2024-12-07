<?php

try {
    // On se connecte à MySQL
    $mysqlClient2 = new PDO('mysql:host=localhost;dbname=recipe_demo;charset=utf8', 'root', '');
} catch (Exception $e) {
    // En cas d'erreur, on affiche un message et on arrête tout
    die('Erreur : ' . $e->getMessage());
}

$id = $_GET['id']; // recup l'id de mon URL

$sqlQuery2 = 'SELECT recipe.id_recipe, recipe.recipe_name, category.category_name, recipe.preparation_time, recipe.instructions,
                     ingrediant.ingrediant_name, recipe_ingredients.quantity, ingrediant.price
             FROM recipe
             INNER JOIN category ON category.id_category = recipe.id_category
             INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
             INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
             WHERE recipe.id_recipe = :id';

$recipesStatement2 = $mysqlClient2->prepare($sqlQuery2);
$recipesStatement2->bindParam(':id', $id, PDO::PARAM_INT); // lie mon :id à ma variable $id puis filtre INT pour s'assuré que ce n'est pas des string
$recipesStatement2->execute();
$recipes = $recipesStatement2->fetch(); // va chercher une info/ligne

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1><?php echo $recipes['recipe_name']; ?></h1>
    <table border = 1>
    <thead>
        <tr>
            <th>Temps de préparation</th>
            <th>Catégorie</th>
            <th>Ingredient</th>
            <th>Instructions</th>
        </tr>
    </thead>
        <tbody>
                <tr>
                </tr>
            </tbody>
        </table>
</body>
</html>
