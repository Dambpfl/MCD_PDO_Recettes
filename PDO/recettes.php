<?php

try {
    // Connexion à MySQL
    $mysqlClient = new PDO('mysql:host=localhost;dbname=recipe_demo;charset=utf8', 'root', '');
} catch (Exception $e) {
    // En cas d'erreur, on affiche un message et on arrête tout
    die('Erreur : ' . $e->getMessage());
}

// Requête pour récupérer les recettes avec leurs ingrédients
$sqlQuery = 'SELECT recipe.id_recipe, recipe.recipe_name, recipe.preparation_time, 
                    category.category_name, recipe.instructions, ingrediant.ingrediant_name,
                    recipe_ingredients.quantity, recipe_ingredients.unity, ingrediant.price
            FROM recipe
            INNER JOIN category ON category.id_category = recipe.id_category
            LEFT JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
            LEFT JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
            ORDER BY recipe.preparation_time DESC';

$recipesStatement = $mysqlClient->prepare($sqlQuery);
$recipesStatement->execute();
$recipesData = $recipesStatement->fetchAll();

// Groupe les ingrédients par recette
$recipes = [];
foreach ($recipesData as $recipe) {

    $recipeId = $recipe['id_recipe'];

    // RECETTES
    // verif si recette avec id existe sinon add
    if (!isset($recipes[$recipeId])) {

        // Ajout infos de la recette
        $recipes[$recipeId] = [
            'recipe_name' => $recipe['recipe_name'],
            'preparation_time' => $recipe['preparation_time'],
            'category_name' => $recipe['category_name'],
            'instructions' => $recipe['instructions'],
            'ingredients' => [] // Initialisation de la liste des ingrédients
        ];
    }
    // INGREDIENTS
    // Ajout des ingrédients si ils existent
    if (!empty($recipe['ingrediant_name'])) {

        $recipes[$recipeId]['ingredients'][] = [
            'name' => $recipe['ingrediant_name'],
            'quantity' => $recipe['quantity'],
            'unity' => $recipe['unity'],
            'price' => $recipe['price']
        ];
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <title>Mes recettes</title>
</head>
<body>
    <h1>Mes recettes</h1>

    <div class="recettes">
        <?php foreach ($recipes as $id_recipe => $recipe) { ?>
            <a class="recette" href="detailRecette.php?id=<?php echo $id_recipe; ?>">
                <div class="name-recette"><?php echo ($recipe['recipe_name']); ?></div>
                <div class="time"><i class="fa-regular fa-clock"></i> <?php echo ($recipe['preparation_time']); ?> min</div>
                <div class="name-category"><?php echo ($recipe['category_name']); ?></div>
                <div class="instruction"><?php echo ($recipe['instructions']); ?></div>
                <h4>Ingrédients :</h4>
                <div class="ingredients">
                    <?php foreach ($recipe['ingredients'] as $ingredient) { ?>
                        <div class="ingredient">
                            <div class="infos-ingredient"><?php echo ($ingredient['name']); ?><br>
                            <?php echo ($ingredient['quantity']); echo ($ingredient['unity']); ?> </div>
                        </div>
                    <?php } ?>
                </div>
            </a>
        <?php } ?>
    </div>
</body>
</html>
