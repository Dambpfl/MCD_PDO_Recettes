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


-- Insérer une nouvelle recette pates a la carbonara prepa 20min


-- Modifier le nom de la recette id3


-- Supprimer la recette2


-- Afficher le prix total de la recette5


-- Afficher les detail de la recette5


-- Ajouter un ingredient Poivre, unité cuillère à café + prix


-- Modifier le prix de lingredient 12


-- Afficher le nombre de recette par catégorie (entrée,plat,dessert)
SELECT COUNT(id_category) FROM recipe
GROUP BY id_category;

-- Afficher les recettes qui contiennent l'ingrédient Poulet


-- Met à jour le temps de prépa de -5 min


-- Affiche les recettes sans ingrédients coutant + de 2€


-- Ajoute un ingredient à une recette