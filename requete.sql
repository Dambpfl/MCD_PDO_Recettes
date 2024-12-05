-- Afficher toutes les recettes disponibles dans lordre decroissant du temps de prepa
SELECT recipe_name, category_name, preparation_time  
FROM recipe
INNER JOIN category ON recipe.id_category = category.id_category
ORDER BY preparation_time DESC;

-- Fait apparaitre le nb dingredients par recette
SELECT recipe_name, COUNT(id_ingredient)
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
GROUP BY recipe_name;

-- Afficher les recettes de moins de 30min
SELECT recipe_name, preparation_time 
FROM recipe
WHERE preparation_time < 30;

-- Afficher les recettes dont le nom contient salade
SELECT recipe_name
FROM recipe
WHERE recipe_name LIKE "%Salade%" -- "Salade%" marche aussi dans mon cas, maj pas obligatoire

-- Insérer une nouvelle recette pates a la carbonara prepa 20min
INSERT INTO recipe (recipe_name, preparation_time, instructions, id_category) -- ("*" ne fonctionne pas)
VALUES ("Pâtes à la carbonara", 20, "Cuire les pates", 2) -- bien respecter l'ordre -- Verif avec SELECT * FROM recipe

-- Modifier le nom de la recette id3
UPDATE recipe
SET recipe_name = "Poulet curry" -- maj de recipe_name
WHERE id_recipe = 3  -- id à changer

-- Supprimer la recette numero 2
DELETE FROM recipe_ingredients -- enfant de recipe obliger de la supprimer avant
WHERE id_recipe = 2;
 
puis
 
DELETE FROM recipe -- supprimer le parent
WHERE id_recipe = 2

-- Afficher le prix total de la recette 5
SELECT recipe.id_recipe, recipe_name, SUM(ingrediant.price*recipe_ingredients.quantity)
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
WHERE recipe.id_recipe = 5
GROUP BY recipe.id_recipe, recipe.recipe_name


-- Afficher le detail de la recette 5
SELECT recipe_name, ingrediant_name, quantity, unity, price
FROM recipe
INNER JOIN recipe_ingredients ON recipe.id_recipe = recipe_ingredients.id_recipe
INNER JOIN ingrediant ON recipe_ingredients.id_ingredient = ingrediant.id_ingrediant
WHERE recipe.id_recipe = 5


-- Ajouter un ingredient Poivre, unité cuillère à café + prix
INSERT INTO ingrediant (ingrediant_name, price)
VALUES ("Poivre", 0.4)

-- Modifier le prix de lingredient 12
UPDATE ingrediant
SET price = 1.4
WHERE id_ingrediant = 12

-- Afficher le nombre de recette par catégorie (entrée,plat,dessert)
SELECT category.category_name, COUNT(recipe.id_recipe)
FROM category
INNER JOIN recipe ON category.id_category = recipe.id_category
GROUP BY category_name

-- Afficher les recettes qui contiennent l'ingrédient Poulet
SELECT recipe_name
FROM recipe
WHERE recipe_name LIKE "%Poulet%"

-- Met à jour le temps de prépa de toute les recettes de -5 min
UPDATE recipe
SET preparation_time = preparation_time - 5 -- NE PAS OUBLIER DE SOUSTRAIRE A LA VALEUR ACTUEL

-- Affiche les recettes sans ingrédients coutant + de 2€


-- Ajoute un ingredient à une recette