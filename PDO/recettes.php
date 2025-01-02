<?php

 try {
    // On se connecte à MySQL
    $mysqlClient = new PDO('mysql:host=localhost;dbname=recipe_demo;charset=utf8', 'root', '');
} catch (Exception $e) {
    // En cas d'erreur, on affiche un message et on arrête tout
    die('Erreur : ' . $e->getMessage());
}

// On récupère tout le contenu de la table recipes
$sqlQuery = 'SELECT recipe.id_recipe, recipe.recipe_name, recipe.preparation_time, category.category_name, recipe.instructions  -- ne pas oublié l id --
             FROM recipe
             INNER JOIN category ON category.id_category = recipe.id_category
             ORDER BY preparation_time DESC';
$recipesStatement = $mysqlClient->prepare($sqlQuery);
$recipesStatement->execute();
$recipes = $recipesStatement->fetchAll(); // va chercher all

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <title>Document</title>
</head>
<body>
    <h1>Mes recettes</h1>

            <div class="recettes">               
                <?php foreach ($recipes as $recipe) {?>
                    <a class="recette" href="detailRecette.php?id=<?php echo $recipe["id_recipe"] ?>">
                        <div class="name-recette"><?php echo $recipe['recipe_name']; ?></div> <!-- echo de id obligatoire sinon pas de changement dans l'URL -->
                        <div class="time"><i class="fa-regular fa-clock"></i> <?php echo $recipe['preparation_time']; ?> min</div>
                        <div class="name-category"><?php echo $recipe['category_name']; ?></div>
                        <div class="instruction"><?php echo $recipe['instructions']; ?></div>
                    </a>
                <?php } ?>
            </div>

</body>
</html>