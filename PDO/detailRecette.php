<?php

try {
    // On se connecte à MySQL
    $mysqlClient2 = new PDO('mysql:host=localhost;dbname=recipe_demo;charset=utf8', 'root', '');
} catch (Exception $e) {
    // En cas d'erreur, on affiche un message et on arrête tout
    die('Erreur : ' . $e->getMessage());
}

$sqlQuery2 = 'SELECT recipe.recipe_name, category.category_name, recipe.preparation_time, recipe.instructions,
                     ingrediant.ingrediant_name, recipe_ingredients.quantity, ingrediant.price
             FROM recipe
             INNER JOIN category ON category.id_category = recipe.id_category
             INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
             INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant';

$recipesStatement2 = $mysqlClient2->prepare($sqlQuery2);
$recipesStatement2->execute();
$recipes = $recipesStatement2->fetch(); // va chercher une info

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Detail recette</h1>
    <table border = 1>
    <thead>
        <tr>
            <th>Recette</th>
            <th>Temps de préparation</th>
            <th>Catégorie</th>
            <th>Ingredient</th>
            <th>Instructions</th>
        </tr>
    </thead>
        <tbody>
                <tr>
                    <td><?php echo $recipes['recipe_name']; ?></td>
                        <!-- trouver comment lié a l'id -->
                </tr>
            </tbody>
        </table>
</body>
</html>
